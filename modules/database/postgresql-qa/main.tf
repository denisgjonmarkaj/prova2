/**
 * # PostgreSQL Module for OCI
 *
 * This module creates a managed PostgreSQL instance in Oracle Cloud Infrastructure.
*  It is configured for production environments with regional high availability by default.
 */


resource "oci_psql_db_system" "postgresql_db" {
  compartment_id = var.compartment_id
  db_version     = var.db_version
  display_name   = "${var.display_name}-${var.environment}"
  
  network_details {
    subnet_id = var.subnet_id
    nsg_ids   = var.nsg_ids
  }
  
  shape = var.shape
  
  storage_details {
    is_regionally_durable = var.is_regionally_durable
    system_type           = var.storage_system_type
    
    
    ## Specify availability_domain only if is_regionally_durable is false
    availability_domain = var.is_regionally_durable ? null : var.availability_domain
  }
  
  credentials {
    password_details {
      password_type = "PLAIN_TEXT"
      password      = var.db_admin_password
    }
    username = var.db_admin_username
  }
  
  instance_count             = var.instance_count
  instance_memory_size_in_gbs = var.memory_size_in_gbs
  instance_ocpu_count        = var.cpu_core_count
  

  # Configuring automatic backups
  
  management_policy {
    backup_policy {
      kind          = var.backup_policy_kind
      backup_start  = var.backup_start_time
      retention_days = var.backup_retention_days
      days_of_the_week = var.backup_policy_kind == "WEEKLY" ? var.backup_days_of_week : null
      days_of_the_month = var.backup_policy_kind == "MONTHLY" ? var.backup_days_of_month : null
    }
  }
 
}