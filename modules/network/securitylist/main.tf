
###########################
# Network Security Groups #
###########################

resource "oci_core_network_security_group" "kubernetes-services" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "kubernetes-services-${var.environment}"

}

resource "oci_core_network_security_group" "nfs-service" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "nfs-service-${var.environment}"
}




##########################################
# Network Security Groups Security Rules #
##########################################

#resource "oci_core_network_security_group_security_rule" "k8s_api_server" {
  #network_security_group_id = oci_core_network_security_group.kubernetes-services.id
 # direction                 = "INGRESS"
 # protocol                  = "6"
 # source                    = "10.2.5.0/24"
 # description               = "Allow K8s API Server access"
 # stateless                = false
 # tcp_options {
 #  destination_port_range {
  #   min = 6443
  #   max = 6443
  # }
 #}
#}

resource "oci_core_network_security_group_security_rule" "k8s_api_server" {
 network_security_group_id = oci_core_network_security_group.kubernetes-services.id
 direction                 = "INGRESS"
 protocol                  = "All"  
  source                    = "10.2.5.0/24"
  description               = "Allow K8s API Server access"
  stateless                = false
}


resource "oci_core_network_security_group_security_rule" "Allow_worker_nodes_to_communicate_with_OKE" {
  network_security_group_id = oci_core_network_security_group.kubernetes-services.id
  direction                 = "EGRESS"
  protocol                  = "6"
  description              = "Allow worker nodes to communicate with OKE"
  destination              = "all-fra-services-in-oracle-services-network"
  destination_type         = "SERVICE_CIDR_BLOCK"
  stateless               = false
}



resource "oci_core_network_security_group_security_rule" "Internal_Private_Traffic_IN" {
  network_security_group_id = oci_core_network_security_group.kubernetes-services.id
  direction                 = "INGRESS"
  protocol                  = "All"  #nel caso 6
  description               = "Internal Private Traffic IN"
  source                    = var.net_cidr_private
  stateless                = false
  #tcp_options {
  #destination_port_range {
   #  min = 443
    # max = 443
   #}
 #}
}


resource "oci_core_network_security_group_security_rule" "Internal_Private_Traffic_OUT" {
  network_security_group_id = oci_core_network_security_group.kubernetes-services.id
  direction                 = "EGRESS"
  protocol                  = "6" #nel caso All
  description               = "Internal Private Traffic OUT"
  destination               = var.net_cidr_private
  stateless                = false
  #tcp_options {
  #destination_port_range {
    # min = 443
    # max = 443
   #}
 #}
}

# permette tutto il traffico interno al VCN, tolgo nel caso

resource "oci_core_network_security_group_security_rule" "All_traffic_from_Load_Balancer_Private" {
  network_security_group_id = oci_core_network_security_group.kubernetes-services.id
  direction                 = "INGRESS"
  protocol                  = "All"
  description               = "All traffic from Load Balancer Private"
  source                    = var.net_cidr_private_lb
  stateless                = false
}

######## NFS Service #########
resource "oci_core_network_security_group_security_rule" "NFS_Ports_Egress_2048" {
  network_security_group_id = oci_core_network_security_group.nfs-service.id
  direction                 = "EGRESS"
  protocol                  = "6"
  description               = "NFS Ports Egress 2048"
  destination               = var.net_cidr_private
  stateless                = false
  tcp_options {
   destination_port_range {
     min = 2048
     max = 2050
   }
  }
}

resource "oci_core_network_security_group_security_rule" "NFS_Ports_Egress_111" {
  network_security_group_id = oci_core_network_security_group.nfs-service.id
  direction                 = "EGRESS"
  protocol                  = "6"
  description               = "NFS Ports Egress 111"
  destination               = var.net_cidr_private
  stateless                = false
  tcp_options {
   destination_port_range {
     min = 111
     max = 111
   }
  }
}

resource "oci_core_network_security_group_security_rule" "NFS_Ports_Egress_111_UDP" {
  network_security_group_id = oci_core_network_security_group.nfs-service.id
  direction                 = "EGRESS"
  protocol                  = "17"
  description               = "NFS Ports Egress 111 UDP"
  destination               = var.net_cidr_private
  stateless                = false
  udp_options {
    destination_port_range {
      min = 111
      max = 111
    }
  }
}

resource "oci_core_network_security_group_security_rule" "NFS_Ports_Ingress_111" {
  network_security_group_id = oci_core_network_security_group.nfs-service.id
  direction                 = "INGRESS"
  protocol                  = "6"
  description               = "NFS Ports Ingress 111"
  source                    = var.net_cidr_private
  stateless                = false
  tcp_options {
    destination_port_range {
      min = 111
      max = 111
    }
  }
}

resource "oci_core_network_security_group_security_rule" "NFS_Ports_Ingress_2048" {
  network_security_group_id = oci_core_network_security_group.nfs-service.id
  direction                 = "INGRESS"
  protocol                  = "6"
  description               = "NFS Ports Ingress 2048"
  source                    = var.net_cidr_private
  stateless                = false
  tcp_options {
    destination_port_range {
      max = 2050
      min = 2048
    }
  }
}

resource "oci_core_network_security_group_security_rule" "NFS_Ports_Ingress_111_UDP" {
  network_security_group_id = oci_core_network_security_group.nfs-service.id
  direction                 = "INGRESS"
  protocol                  = "17"
  description               = "NFS Ports Ingress 111 UDP"
  source                    = var.net_cidr_private
  stateless                = false
  udp_options {
    destination_port_range {
      min = 111
      max = 111
    }
  }
}



#######################
# Security Rules List #
#######################

resource "oci_core_security_list" "network_private" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "network-${var.environment}-private"

  ingress_security_rules {
    protocol    = "6"
    source      = "10.2.5.0/24"
    description = "Allow K8s API access"
    stateless   = false
    tcp_options {
      min = 6443
      max = 6443
    }
  }


  ingress_security_rules {
    protocol    = "ALL"
    source      = var.vcn_cidr
    description = "Allow all traffic between instances in the VCN"
    stateless   = false
  }

  ingress_security_rules {
    protocol    = 1 
    source      = "0.0.0.0/0"
    description = "Allow ICMP"
    stateless   = false
  }

  ingress_security_rules {
    protocol    = "ALL"
    source      = var.net_cidr_private
    description = "Allow all traffic from worker nodes"
    stateless   = false
  }


  ingress_security_rules {
    protocol    = "all"
    source      = "all-fra-services-in-oracle-services-network"
    description = "Allow all Oracle services"
    stateless   = false
    source_type = "SERVICE_CIDR_BLOCK"
  }

  
  ingress_security_rules {
    protocol    = "6"
    source      = "10.2.5.0/24"
    description = "Allow SSH from ePress"
    stateless   = false
    tcp_options {
      min = 22
      max = 22
    }
  }





  ######## Egress Rules ##############


egress_security_rules {
    destination      = "0.0.0.0/0"
    protocol         = "ALL"
    description      = "Allow all outbound traffic"
    stateless        = false
  }

  egress_security_rules {
    destination      = var.vcn_cidr
    protocol         = "ALL"
    description      = "Allow all traffic within VCN"
    stateless        = false
  }

  egress_security_rules {
    protocol         = "6"
    destination      = "all-fra-services-in-oracle-services-network"
    description      = "Allow Oracle Registry access"
    stateless        = false
    destination_type = "SERVICE_CIDR_BLOCK"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination = "10.2.5.0/24"
    protocol    = "6"
    description = "Allow SSH to ePress"
    stateless   = false
    tcp_options {
      min = 22
      max = 22
    }
  }
}

#### Security List per Load Balancer privato

resource "oci_core_security_list" "network_private_lb" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "network-${var.environment}-private-lb"

  egress_security_rules {
    destination = var.net_cidr_private
    protocol    = "6"
    description = "Allow HTTPS to private subnet"
    stateless   = false
    tcp_options {
      min = 443
      max = 443
    }
  }


  egress_security_rules {
    destination = var.net_cidr_private
    protocol    = "6"
    description = "Allow HTTP to private subnet"
    stateless   = false
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol    = "6"  
    source      = var.net_cidr_private
    description = "Allow HTTPS from private subnet"
    stateless   = false
    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    protocol    = "6"  
    source      = var.net_cidr_private
    description = "Allow HTTP from private subnet"
    stateless   = false
    tcp_options {
      min = 80
      max = 80
    }
  }
}


###### Security List per Load Balancer pubblico


resource "oci_core_security_list" "network_public" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "network-${var.environment}-public"

  egress_security_rules {
    destination = var.net_cidr_private
    protocol    = "6"
    description = "Allow HTTPS to private subnet"
    stateless   = false
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination = var.net_cidr_private
    protocol    = "6"
    description = "Allow HTTP to private subnet"
    stateless   = false
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "Allow HTTPS from internet"
    stateless   = false
    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "Allow HTTP from internet"
    stateless   = false
    tcp_options {
      min = 80
      max = 80
    }
  }
}



resource "oci_core_security_list" "network_public_lb" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "network-${var.environment}-public-lb"

  egress_security_rules {
    destination = var.net_cidr_private
    protocol    = "6"
    description = "Allow HTTPS to private subnet"
    stateless   = false
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination = var.net_cidr_private
    protocol    = "6"
    description = "Allow HTTP to private subnet"
    stateless   = false
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "Allow HTTPS from internet"
    stateless   = false
    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "Allow HTTP from internet"
    stateless   = false
    tcp_options {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group" "postgresql_service" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "postgresql-service-${var.environment}"
}

# Allow PostgreSQL port access from private subnet
resource "oci_core_network_security_group_security_rule" "postgresql_access_from_private" {
  network_security_group_id = oci_core_network_security_group.postgresql_service.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source                    = var.net_cidr_private
  description               = "Allow PostgreSQL access from private subnet"
  stateless                 = false
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}

# Allow outbound traffic to private subnet
resource "oci_core_network_security_group_security_rule" "postgresql_egress_to_private" {
  network_security_group_id = oci_core_network_security_group.postgresql_service.id
  direction                 = "EGRESS"
  protocol                  = "6" # TCP
  destination               = var.net_cidr_private
  description               = "Allow outbound traffic to private subnet"
  stateless                 = false
}