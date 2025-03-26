variable "vcn_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
}

variable "vcn_private_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
} 

variable "compartment_id" {
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