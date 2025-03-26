variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}


variable "vcn_cidr" {
    #default = "10.253.51.0/24"
    description = "The cidr network"
    type        = string    
}


#variable "vcn_cidr" {
#    default = "10.253.51.0/24"
#}

variable "net_cidr_private" {
#  default =  "10.253.51.0/26"
    description = "The cidr_private network"
    type        = string 
}

variable "net_cidr_private_lb" {
    description = "The cidr_private_lb network"
    type        = string   
}

variable "net_cidr_public" {
#  default =  "10.253.51.128/26"
    description = "The cidr_public network"
    type        = string  
}

variable "net_cidr_public_lb" {
#  default = "10.253.51.192/26"
    description = "The cidr_public_lb network"
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

variable "drg_id" {
  description = "The ID of the DRG"
  type        = string
}

variable "private_security_list" {
  description = "The ID of the DRG"
  type        = string
}

variable "private_lb_security_list" {
  description = "The ID of the DRG"
  type        = string
}

variable "public_security_list" {
  description = "The ID of the DRG"
  type        = string
}

variable "public_lb_security_list" {
  description = "The ID of the DRG"
  type        = string
}
