variable "vcn_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "availability_domain_1" {
  type = string
}