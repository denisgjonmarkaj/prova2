variable "vcn_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
}

variable "vcn_private_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
} 

variable "compartment_compute_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "compartment_storage_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}
variable "InstanceShape" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "ImageID" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "availability_domain_1" {
  type = string
}

#variable "elasticsearch_block_volume" {
#  type = string
#}

variable "nfs_service_nsg_id" {
  type = string
}

variable "ssh_public_key_elastic" {
  # ssh public key elastic
  type = string
}

variable "tenancy_ocid" {
  # ssh public key elastic
  type = string
}
