terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0" # Check compatibility version
    }
  }

  backend "s3" {
    bucket                      = "terraform"
    key                         = "siav-bmw/development/terraform.tfstate"
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
  compartment_id   = var.compartment-net_ocid
  route_table_id   = module.routetable.network_private_route_table_id
  route_table_id_p = module.routetable.network_public_route_table_id
  drg_id           = module.drg.DRG-siav-bmw
  net_cidr_private = var.net_cidr_private
  net_cidr_private_lb = var.net_cidr_private_lb
  net_cidr_public = var.net_cidr_public
  net_cidr_public_lb = var.net_cidr_public_lb
  vcn_cidr = var.vcn_cidr
  private_security_list = module.securitylist.private_security_list_id
  private_lb_security_list = module.securitylist.private_lb_security_list_id
  public_security_list = module.securitylist.public_security_list_id
  public_lb_security_list = module.securitylist.public_lb_security_list_id
}  
module "gateway" {
  source           = "../../modules/network/gateway"
  vcn_id           = module.vnc.vcn_details.id
  environment      = var.environment
  compartment_id   = var.compartment-net_ocid
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
  compartment_id   = var.compartment-net_ocid
  drg_id           = module.drg.DRG-siav-bmw
}

module "securitylist" {
  source           = "../../modules/network/securitylist"
  vcn_id           = module.vnc.vcn_details.id
  compartment_id   = var.compartment-net_ocid  
  vcn_private_id   = module.vnc.vcn_private_details.id
  environment      = var.environment
  vcn_cidr = var.vcn_cidr
  net_cidr_private = var.net_cidr_private
  net_cidr_private_lb = var.net_cidr_private_lb
  net_cidr_public = var.net_cidr_public
  net_cidr_public_lb = var.net_cidr_public_lb
}

module "compute-dev" {
  source           = "../../modules/compute/compute-dev"
  vcn_id           = module.vnc.vcn_details.id
  vcn_private_id   = module.vnc.vcn_private_details.id
  compartment_compute_id   = var.compartment-compute_ocid
  compartment_storage_id   = var.compartment-storage_ocid
  InstanceShape    = var.InstanceShape
  ImageID          = var.ImageID
  environment      = var.environment
  availability_domain_1 = var.availability_domain_1  
  #elasticsearch_block_volume = module.storage-dev.elasticsearch_block_volume.id
  nfs_service_nsg_id = module.securitylist.nfs_service_nsg_id
  ssh_public_key_elastic = var.ssh_public_key_elastic
  tenancy_ocid  = var.tenancy_ocid
}
module "storage-dev" {
  source           = "../../modules/storage/storage-dev"
  vcn_id           = module.vnc.vcn_details.id
  compartment_id   = var.compartment-storage_ocid
  availability_domain_1 = var.availability_domain_1  

}