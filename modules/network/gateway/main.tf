terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}
#######################
# INTERNET GATEWAY    #
#######################

resource "oci_core_internet_gateway" "internet_gateway" {
  #Required
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

  #Optional
  display_name   = "internet-gateway-${var.environment}"
}


#######################
#    NAT GATEWAY      #
#######################

resource "oci_core_nat_gateway" "nat_gateway" {
  #Required
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

  #Optional
  display_name   = "nat-gateway-${var.environment}"
}

#######################
#    Attach-DRG       #
#######################

resource "oci_core_drg_attachment" "Attach_DRG_network" {
  #Required
  drg_id       = var.drg_id
  display_name = "Attach-DRG-network-${var.environment}"
  network_details {
    id             = var.vcn_id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}



#######################
# Service Gateway (SGW)
#######################

variable "create_service_gateway" {
  description = "whether to create a service gateway. If set to true, creates a service gateway."
  default     = true
  type        = bool
}

data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
  count = var.create_service_gateway == true ? 1 : 0
}

resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = var.compartment_id
  services {
    service_id = lookup(data.oci_core_services.all_oci_services[0].services[0], "id")
  }
  vcn_id       = var.vcn_id
  display_name = "service_gateway"
  count        = var.create_service_gateway == true ? 1 : 0
}
