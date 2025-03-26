terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_containerengine_cluster" "oke_qa" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version 
  name               = "oke-qa"
  vcn_id            = var.vcn_details.id

  freeform_tags = {
    "Environment" = var.environment
    "Project"     = "bmw"
    "ManagedBy"   = "terraform"
    "Component"   = var.component_name
    "Compartment" = "microservices"
    "purpose"     = "kubernetes"
  }

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


data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.ad_number    
}

resource "oci_containerengine_node_pool" "node_qa" {
  cluster_id         = oci_containerengine_cluster.oke_qa.id
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version 
  name               = "node1"
  node_shape         =  var.node_shape

  freeform_tags = {
    "Environment" = var.environment
    "Project"     = "bmw"
    "ManagedBy"   = "terraform"
    "Component"   = var.component_name
    "Compartment" = "microservices"
    "purpose"     = "kubernetes"
  }

  node_config_details {
    size = "1"

    placement_configs {
      availability_domain = data.oci_identity_availability_domain.ad.name
      subnet_id          = var.private_subnet_id
      fault_domains = [
        "FAULT-DOMAIN-1",
        "FAULT-DOMAIN-2",
        "FAULT-DOMAIN-3"
      ]
    }
  
    node_pool_pod_network_option_details {
      cni_type          = "FLANNEL_OVERLAY"
      max_pods_per_node = "31"
      pod_nsg_ids       = var.nsg_ids
      pod_subnet_ids    = [var.private_subnet_id]
    }

  }

  node_shape_config {
    memory_in_gbs = var.node_memory
    ocpus         = var.node_ocpus
  }

  node_source_details {
    source_type = "IMAGE"
    image_id    = var.node_image_id
  }
}





