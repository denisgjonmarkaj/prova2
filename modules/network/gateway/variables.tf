variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "vcn_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "drg_id" {
  description = "The ID of the DRG"
  type        = string
}

variable "route_table_id" {
  description = "The ID of the route table to associate with the subnet"
  type        = string
}

variable "route_table_id_p" {
  description = "The ID of the public route table to associate with the subnet"
  type        = string
}
