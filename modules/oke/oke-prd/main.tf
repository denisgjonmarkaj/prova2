resource "oci_containerengine_cluster" "oke_prd" {
  compartment_id     = var.compartment_id 
  kubernetes_version = var.kubernetes_version 
  name               = "oke-prd"
  vcn_id            = var.vcn_details.id

  cluster_pod_network_options {
    cni_type = "FLANNEL_OVERLAY"
  }

  endpoint_config {
    is_public_ip_enabled = false
    nsg_ids = var.nsg_ids
    subnet_id = var.private_subnet_id
  }

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = true
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [var.private_lb_subnet_id]
  }
}

resource "oci_containerengine_node_pool" "node_prd" {
  cluster_id         = oci_containerengine_cluster.oke_prd.id
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version 
  name               = "node1"
  node_shape         = "VM.Standard.E3.Flex"

  node_config_details {
    size = "0"

    placement_configs {
      availability_domain = data.oci_identity_availability_domain.EU-FRANKFURT-1-AD-1.name 
      subnet_id          = var.private_subnet_id
      fault_domains = [
        "FAULT-DOMAIN-1",    
      ]
    }
  
    node_pool_pod_network_option_details {
      cni_type          = "FLANNEL_OVERLAY"
      max_pods_per_node = "100"
      pod_nsg_ids       = var.nsg_ids
      pod_subnet_ids    = [var.private_subnet_id]
    }

  }

  node_shape_config {
    memory_in_gbs = "8"
    ocpus         = "1"
  }

  node_source_details {
    source_type = "IMAGE"
    image_id    = var.node_image_id
  }
}


data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-1" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
  ad_number      = 1
}
