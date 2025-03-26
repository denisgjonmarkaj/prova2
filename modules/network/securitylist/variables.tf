variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the VCN"
  type        = string
}

variable "environment" {
  description = "Environment (e.g. prod, qa, dev)"
  type        = string
}

variable "vcn_private_id" {
  description = "The VCN ID to associate with the internet gateway"
  type        = string
} 
##############
variable "vcn_cidr" {
  description = "CIDR block of the VCN"
  type        = string
}

variable "net_cidr_private" {
  description = "CIDR block of the private subnet"
  type        = string
}

variable "net_cidr_public" {
  description = "CIDR block of the public subnet"
  type        = string
}

variable "net_cidr_private_lb" {
  description = "CIDR block of the private load balancer subnet"
  type        = string
}

variable "net_cidr_public_lb" {
  description = "CIDR block of the public load balancer subnet"
  type        = string
}