terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}

# Ottieni availability domains dal tenancy
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Configurazione Istanza ElasticSearch
resource "oci_core_instance_configuration" "instance-config-elasticsearch" {
  compartment_id = var.compartment_compute_id
  display_name   = "instance-config-${var.environment}-elasticsearch"

  freeform_tags = {
    "Environment" = var.environment
    "Project"     = "bmw"
    "ManagedBy"   = "terraform"
    "Component"   = "elasticsearch"
    "Compartment" = "compute"
  }
  
  instance_details {
    instance_type = "compute"

    # Configurazione del block volume
    block_volumes {
      attach_details {
        device       = "/dev/oracleoci/oraclevdc"
        display_name = "volumeattachment-elastic"
        is_read_only = "false"
        is_shareable = "false"
        type         = "iscsi"
      }
      create_details {
        compartment_id = var.compartment_storage_id
        display_name   = "elasticsearch_block_volume"
        size_in_gbs    = var.compute_block_volume_size_gb
        vpus_per_gb    = var.block_volume_vpus
      }
    }
    
    launch_details {
      availability_domain = var.availability_domain_name
      compartment_id      = var.compartment_compute_id
      shape               = var.InstanceShape
      launch_mode         = "PARAVIRTUALIZED"
      
      create_vnic_details {
        nsg_ids = [var.nfs_service_nsg_id]
      }
      
      shape_config {
        ocpus         = 4  # Come da screenshot: 4 OCPU
        memory_in_gbs = 32 # Come da screenshot: 32GB di memoria
      }
      
      source_details {
        source_type             = "image"
        image_id                = var.ImageID
        boot_volume_size_in_gbs = var.compute_boot_volume_size_gb
      }
      
      launch_options {
        network_type = "PARAVIRTUALIZED"
      }
      
      metadata = { 
        "ssh_authorized_keys" : var.ssh_public_key_elastic
        "user_data" = base64encode(<<EOF
#!/bin/bash
curl --fail -H "Authorization: Bearer Oracle" -L0 http://169.254.169.254/opc/v2/instance/metadata/oke_init_script | base64 --decode >/var/run/oke-init.sh
bash /var/run/oke-init.sh
echo "Espandi il filesystem root"
/usr/libexec/oci-growfs -y
EOF
        )
      }
    }
  }
}

# Pool di istanze ElasticSearch
resource "oci_core_instance_pool" "elasticsearch_pool" {
  compartment_id            = var.compartment_compute_id
  instance_configuration_id = oci_core_instance_configuration.instance-config-elasticsearch.id
  display_name              = "instance-pool-elasticsearch-${var.environment}"
  
  freeform_tags = {
    "Environment" = var.environment
    "Project"     = "bmw"
    "ManagedBy"   = "terraform"
    "Component"   = "elasticsearch"
    "Compartment" = "compute"
  }
  
  placement_configurations {
    availability_domain = var.availability_domain_name
    primary_subnet_id   = var.vcn_private_id
    fault_domains       = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
  }
  
  size = 3 