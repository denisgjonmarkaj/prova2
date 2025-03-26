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


#############################
# persitence configuration #
#############################

resource "oci_core_instance_configuration" "instance-config-elasticsearch" {
  compartment_id = var.compartment_compute_id
  #defined_tags = {"env" = "${var.environment}"}
  display_name = "instance-config-${var.environment}-elasticsearch"

  instance_details {
    instance_type = "compute"
    #block_storage_attach_details {
    #      attach_details {
    #        device       = "/dev/oracleoci/oraclevdc"
    #        display_name = "volumeattachment-Elastic"
    #        type         = "iscsi"
    #      }
    #      volume_id    = var.elasticsearch_block_volume
    #}
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
        size_in_gbs    = "100"
        vpus_per_gb    = "10"
      }
    }
    launch_details {
      # if you want set another availability domain chanche the number [0] in [1] or [2]
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      compartment_id      = var.compartment_compute_id
      shape               = var.InstanceShape
      launch_mode         = "PARAVIRTUALIZED"
      create_vnic_details {
        nsg_ids = [var.nfs_service_nsg_id]
      }
      shape_config {
        ocpus         = "2"
        memory_in_gbs = "16"
      }
      source_details {
        source_type = "image"
        image_id    = var.ImageID
        boot_volume_size_in_gbs = 100
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
echo "Grow Root Filesystem"
/usr/libexec/oci-growfs -y
EOF
        )        
         }    
  }
}
}


##################
# persitence pool #
###################

resource "oci_core_instance_pool" "instance-pool-elasticsearch" {
  compartment_id            = var.compartment_compute_id
  instance_configuration_id = oci_core_instance_configuration.instance-config-elasticsearch.id
  placement_configurations {
    #Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    primary_subnet_id   = var.vcn_private_id

    #Optional
    fault_domains =  ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
  }
  size         = "1"
  display_name = "instance-pool-elasticsearch"
}