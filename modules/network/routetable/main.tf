terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}
resource "oci_core_route_table" "network_private" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "network-private-${var.environment}"
  route_rules {
    network_entity_id = var.nat_id
    destination       = "0.0.0.0/0"
  }
  route_rules {
    network_entity_id = var.drg_id
    destination       = "10.2.5.0/24"
  }
  route_rules {
    network_entity_id =  var.svc_gateway_id
    destination       = "all-fra-services-in-oracle-services-network"
    destination_type  = "SERVICE_CIDR_BLOCK"
  }
}

resource "oci_core_route_table" "network_public" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "network-public-${var.environment}"
  route_rules {
    network_entity_id = var.internet_gateway
    destination       = "0.0.0.0/0"
  }
  route_rules {
    network_entity_id = var.drg_id
    destination       = "10.2.5.0/24"
  }

}