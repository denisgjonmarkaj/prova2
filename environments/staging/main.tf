terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0" # Check compatibility version
    }
  }

  backend "s3" {
    bucket                      = "terraform"
    key                         = "siav-bmw/staging/terraform.tfstate"
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
  compartment_id   = var.compartment_network-qa_ocid
  route_table_id   = module.routetable.network_private_route_table_id
  route_table_id_p = module.routetable.network_public_route_table_id
  drg_id           = module.drg.DRG-siav-bmw

  net_cidr_private     = var.net_cidr_private
  net_cidr_private_lb  = var.net_cidr_private_lb
  net_cidr_public      = var.net_cidr_public
  net_cidr_public_lb   = var.net_cidr_public_lb
  vcn_cidr         = var.vcn_cidr         
  private_security_list = module.securitylist.private_security_list_id
  private_lb_security_list = module.securitylist.private_lb_security_list_id
  public_security_list = module.securitylist.public_security_list_id
  public_lb_security_list = module.securitylist.public_lb_security_list_id
}

module "gateway" {
  source           = "../../modules/network/gateway"
  vcn_id           = module.vnc.vcn_details.id
  environment      = var.environment
  compartment_id   = var.compartment_network-qa_ocid
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
  compartment_id   = var.compartment_network-qa_ocid
  drg_id           = module.drg.DRG-siav-bmw
}

module "securitylist" {
  source            = "../../modules/network/securitylist"
  environment       = var.environment
  compartment_id    = var.compartment_network-qa_ocid
  vcn_id            = module.vnc.vcn_details.id
  vcn_private_id   = module.vnc.vcn_private_details.id

  vcn_cidr          = var.vcn_cidr
  net_cidr_private  = var.net_cidr_private
  net_cidr_private_lb = var.net_cidr_private_lb
  net_cidr_public   = var.net_cidr_public
  net_cidr_public_lb = var.net_cidr_public_lb
}

module "compute-qa" {
  source                          = "../../modules/compute/compute-qa"
  vcn_id                          = module.vnc.vcn_details.id
  vcn_private_id                  = module.vnc.vcn_private_details.id
  compartment_compute_id          = var.compartment-compute_ocid
  compartment_storage_id          = var.compartment-storage_ocid
  InstanceShape                   = var.InstanceShape
  ImageID                         = var.ImageID
  environment                     = var.environment
  nfs_service_nsg_id              = module.securitylist.nfs_service_nsg_id
  ssh_public_key_elastic          = var.ssh_public_key_elastic
  tag_namespace_name              = module.identity.tag_namespace_name
  tenancy_ocid                    = var.tenancy_ocid
  elasticsearch_instance_ocpus    = var.elasticsearch_instance_ocpus
  elasticsearch_instance_memory   = var.elasticsearch_instance_memory
  elasticsearch_block_volume_size_gb = var.elasticsearch_block_volume_size_gb
  elasticsearch_block_volume_vpus = var.elasticsearch_block_volume_vpus
  elasticsearch_boot_volume_size_gb = var.elasticsearch_boot_volume_size_gb
  elasticsearch_instance_pool_size = var.elasticsearch_instance_pool_size
  elasticsearch_fault_domain = var.elasticsearch_fault_domain
  elasticsearch_availability_domain = var.elasticsearch_availability_domain
}

module "oke_qa" {
  source = "../../modules/oke/oke-qa"
  environment = var.environment
  kubernetes_version  = var.kubernetes_version
  node_image_id     = var.node_image_id
  compartment_id      = var.compartment_microservices-qa_ocid
  vcn_details         = module.vnc.vcn_details
  nsg_ids             = [
    module.securitylist.kubernetes_services_nsg_id,
    module.securitylist.nfs_service_nsg_id
  ]
  private_subnet_id   = module.vnc.private_subnet_id
  private_lb_subnet_id = module.vnc.private_lb_subnet_id
  tag_namespace_name   = module.identity.tag_namespace_name
  tenancy_ocid        = var.tenancy_ocid
  node_shape          = var.InstanceShape
  availability_domain_name = "EU-FRANKFURT-1-AD-1" 
  ad_number = 1 
}

data "oci_identity_availability_domain" "ad1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

module "postgresql" {
  source = "../../modules/database/postgresql-qa"

  # Main parameters
  compartment_id      = var.compartment_db-qa_ocid
  subnet_id           = module.vnc.private_subnet_id
  environment         = var.environment
  nsg_ids             = [module.securitylist.postgresql_service_nsg_id]

  # Database configuration
  display_name        = var.postgresql_display_name
  db_version          = var.postgresql_db_version 
  shape               = var.postgresql_shape  
  cpu_core_count      = var.postgresql_cpu_core_count     
  memory_size_in_gbs  = var.postgresql_memory_size_in_gbs 
  instance_count      = var.postgresql_instance_count
  
  # Credetential
  db_admin_username   = var.postgresql_admin_username
  db_admin_password   = var.postgresql_admin_password
  
  # HA Configuration
  is_regionally_durable = var.postgresql_is_regionally_durable
  availability_domain   = var.postgresql_availability_domain

  # Configurazione backup
  backup_policy_kind   = var.postgresql_backup_policy_kind
  backup_start_time    = var.postgresql_backup_start_time
  backup_retention_days = var.postgresql_backup_retention_days
  backup_days_of_week  = var.postgresql_backup_days_of_week
}