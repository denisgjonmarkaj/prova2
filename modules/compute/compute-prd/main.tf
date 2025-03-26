terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}



#############################
# persitence configuration #
#############################

resource "oci_core_instance_configuration" "instance-config-elasticsearch" {
  compartment_id = var.compartment_id
  defined_tags = {"env" = "prd"}
  display_name = "instance-config-${var.environment}-elasticsearch"

  instance_details {
    instance_type = "compute"
    launch_details {
      availability_domain = var.availability_domain_1
      compartment_id      = var.compartment_id
      shape               = var.InstanceShape
      launch_mode         = "PARAVIRTUALIZED"
      #create_vnic_details {
      #  nsg_ids = [oci_core_network_security_group.nfs-service.id]
      #}
      shape_config {
        ocpus         = "2"
        memory_in_gbs = "16"
      }
      source_details {
        source_type = "image"
        image_id    = var.ImageID
      }
      launch_options {
        network_type = "PARAVIRTUALIZED"
      }
      #metadata = { "ssh_authorized_keys" : var.ssh_public_key_elastic }    
    #block_volumes_details {
    #    volume_id    = var.block_volume_id
    #    device       = "/dev/oracleoci/oraclevdc"
    #    display_name = "volumeattachment-Elastic"
    #    type         = "iscsi"

    #}
  }
}
}

##################
# persitence pool #
###################

resource "oci_core_instance_pool" "instance-pool-elasticsearch" {
  compartment_id            = var.compartment_id
  instance_configuration_id = oci_core_instance_configuration.instance-config-elasticsearch.id
  placement_configurations {
    #Required
    availability_domain = var.availability_domain_1
    primary_subnet_id   = var.vcn_private_id

    #Optional
    #fault_domains = [ FAULT-DOMAIN-1, FAULT-DOMAIN-2, FAULT-DOMAIN-3 ]
  }
  size         = "1"
  display_name = "instance-pool-elasticsearch"
}