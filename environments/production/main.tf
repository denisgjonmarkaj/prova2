terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0" # Check compatibility version
    }
  }

  backend "s3" {
    bucket                      = "terraform"
    key                         = "siav-bmw/production/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    endpoint                    = "https://frppu0qfug61.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

module "global" {
  source         = "../../global"
  admin_user_pk  = var.admin_user_pk
}
provider "oci" {
  tenancy_ocid          = "ocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
  user_ocid             = "ocid1.user.oc1..aaaaaaaabtt7xqqj5e7ja3br6bfjlpz7zjt5kq2b54bbclvgvyszfdiuyzda"
  fingerprint           = "46:f9:f3:d9:b8:8e:d0:40:e1:5e:4a:70:61:c7:4e:d2"
  private_key           =  module.global.private_key_contents
  region                = "eu-frankfurt-1"
}

# Call modules and pass environment-specific variables

module "drg" {
  source           = "../../modules/network/drg"
}


module "vnc" {
  source           = "../../modules/network/vnc"
  environment      = var.environment
  compartment_id   = var.compartment_network-prd_ocid
  route_table_id   = module.routetable.network_private_route_table_id
  route_table_id_p = module.routetable.network_public_route_table_id
  drg_id           = module.drg.DRG-siav-bmw
  vcn_cidr         = var.vcn_cidr
  net_cidr_private = var.net_cidr_private
  net_cidr_private_lb = var.net_cidr_private_lb
  net_cidr_public = var.net_cidr_public
  net_cidr_public_lb = var.net_cidr_public_lb
}

module "gateway" {
  source           = "../../modules/network/gateway"
  vcn_id           = module.vnc.vcn_details.id
  environment      = var.environment
  compartment_id   = var.compartment_network-prd_ocid
  drg_id           = module.drg.DRG-siav-bmw
  route_table_id   = module.routetable.network_private_route_table_id
  route_table_id_p = module.routetable.network_public_route_table_id
}

module "routetable" {
  source           = "../../modules/network/routetable"
  vcn_id           = module.vnc.vcn_details.id
  nat_id           = module.gateway.nat_gateway_private
  svc_gateway_id   = module.gateway.service_gateway
  internet_gateway = module.gateway.internet_gateway
  environment      = var.environment
  compartment_id   = var.compartment_network-prd_ocid
  drg_id           = module.drg.DRG-siav-bmw
}


module "securitylist" {
  source            = "../../modules/network/securitylist"
  environment       = var.environment
  compartment_id    = var.compartment_network-prd_ocid
  vcn_id            = module.vnc.vcn_details.id
  vcn_private_id   = module.vnc.vcn_private_details.id

  vcn_cidr          = var.vcn_cidr
  net_cidr_private  = var.net_cidr_private
  net_cidr_private_lb = var.net_cidr_private_lb
  net_cidr_public   = var.net_cidr_public
  net_cidr_public_lb = var.net_cidr_public_lb
}

module "oke_qa" {
  source = "../../modules/oke/oke-prd"
  kubernetes_version  = var.kubernetes_version
  node_image_id     = var.node_image_id
  compartment_id      = var.compartment_microservices-prd_ocid
  vcn_details         = module.vnc.vcn_details
  nsg_ids             = [
    module.securitylist.kubernetes_services_nsg_id,
    module.securitylist.nfs_service_nsg_id
  ]
  private_subnet_id   = module.vnc.private_subnet_id
  private_lb_subnet_id = module.vnc.private_lb_subnet_id

}
