terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}

#data "oci_identity_availability_domains" "ads" {
#  compartment_id = var.compartment_id
#}

#resource "oci_core_volume" "elasticsearch_block_volume" {
#  compartment_id = var.compartment_id
#  #availability_domain = var.availability_domain_1
#  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0]["name"]
#  display_name = "elasticsearch_block_volume"
#  size_in_gbs = 100
#}

#resource "oci_core_volume_attachment" "elasticsearch_block_attachment" {
#  instance_id = oci_core_instance.example_instance.id
#  volume_id   = oci_core_volume.elasticsearch_block_volume.id
#  attachment_type = "iscsi"  # Oppure "paravirtualized"
#}