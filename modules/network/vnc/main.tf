terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}
resource "oci_core_vcn" "network" {
  dns_label      = "net${var.environment}"
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = "network-${var.environment}"
}

data "oci_core_vcn_dns_resolver_association" "network" {
  vcn_id = oci_core_vcn.network.id  
}

#module "securitylist" {
#  source            = "../securitylist"
#  compartment_id    = var.compartment_id
#  vcn_id            = oci_core_vcn.network.id
#  environment       = var.environment
#  vcn_cidr          = var.vcn_cidr
#  net_cidr_private  = var.net_cidr_private
#  net_cidr_public   = var.net_cidr_public
#  net_cidr_private_lb = var.net_cidr_private_lb
#  net_cidr_public_lb  = var.net_cidr_public_lb
#}

# Subnets
resource "oci_core_subnet" "network_private" {
  vcn_id                     = oci_core_vcn.network.id
  cidr_block                 = var.net_cidr_private
  compartment_id             = var.compartment_id
  display_name               = "network-${var.environment}-private"
  prohibit_public_ip_on_vnic = true
  dns_label                  = "netpriv"
  route_table_id             = var.route_table_id
  #security_list_ids          = [module.securitylist.private_security_list_id] 
  security_list_ids            = [var.private_security_list]
}

resource "oci_core_subnet" "network_private_lb" {
  vcn_id                     = oci_core_vcn.network.id
  cidr_block                 = var.net_cidr_private_lb
  compartment_id             = var.compartment_id
  display_name               = "network-${var.environment}-private-lb"
  prohibit_public_ip_on_vnic = true
  dns_label                  = "netprivlb"
  route_table_id             = var.route_table_id
  #security_list_ids          = [module.securitylist.private_lb_security_list_id] 
  security_list_ids            = [var.private_lb_security_list]  
}

resource "oci_core_subnet" "network_public" {
  vcn_id                     = oci_core_vcn.network.id
  cidr_block                 = var.net_cidr_public
  compartment_id             = var.compartment_id
  display_name               = "network-${var.environment}-public"
  dns_label                  = "netpub"
  route_table_id             = var.route_table_id_p
  prohibit_public_ip_on_vnic = false
  #security_list_ids          = [module.securitylist.public_security_list_id] 
  security_list_ids            = [var.public_security_list]  

}

resource "oci_core_subnet" "network_public_lb" {
  vcn_id                     = oci_core_vcn.network.id
  cidr_block                 = var.net_cidr_public_lb
  compartment_id             = var.compartment_id
  display_name               = "network-${var.environment}-public-lb"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "netpublb"
  route_table_id             = var.route_table_id_p
  #security_list_ids          = [module.securitylist.public_lb_security_list_id] 
  # list of string required, [...] they force conversion to a list when assigned 
  security_list_ids            = [var.public_lb_security_list]  

}