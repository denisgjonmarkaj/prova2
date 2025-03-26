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

variable "nat_id" {
  description = "The NAT Gateway ID to associate with the route table"
  type        = string
}

variable "svc_gateway_id" {
  description = "The ID of the Service Gateway"
  type        = string
}

variable "internet_gateway" {
  description = "The ID of the internet Gateway"
  type        = string
}

variable "drg_id" {
  description = "The ID of the DRG"
  type        = string
}