variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

#######################
#        region       #
#######################


variable "region" {
  description = "The OCI region where the resources will be created."
  type        = string
  default     = "eu-frankfurt-1"
}

#######################
#        tenant       #
#######################

variable "tenancy_ocid" {
  description = "A tenancy OCID."
  default     = "ocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
}

#######################
#        terraform    #
#######################

variable "admin_user_pk" {
  description = "Terraform admin user private key"
  default     = "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaarhmdlkaa342vyrs3kxcbb6e7pkpn3qzmcsox3qb4yttlszr73jia"
}

variable "admin_user_fingerprint" {
  description = "Terraform admin user fingerprint"
  type        = string
  default     = "46:f9:f3:d9:b8:8e:d0:40:e1:5e:4a:70:61:c7:4e:d2"
}

variable "admin_user_ocid" {
  description = "Terraform admin user ocid"
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaabtt7xqqj5e7ja3br6bfjlpz7zjt5kq2b54bbclvgvyszfdiuyzda"
}



#######################
#    compartments     #
#######################


variable "parent_compartment_network" {
    default = "ocid1.compartment.oc1..aaaaaaaavsh27mzzzppus7xhx6o3nlypoqr6n56eeb2cqkfo5x4ewdo2bbza"
}
variable "compartment-net_ocid" {
  description = "Networw dev compartment"
  default = "ocid1.compartment.oc1..aaaaaaaajiupodf5lgjbzpiqfb2jn2ybdd5q7l75edv7hda2ql3nnk65raua"
  }


variable "compartment-compute_ocid" {
  description = "Networw dev compartment"
  default = "ocid1.compartment.oc1..aaaaaaaast6lwy5ace26s4pqhi6sbpwy3oxeir7afvgdge2dlidycrtehwza"
  }

variable "compartment-storage_ocid" {
  description = "Networw dev compartment"
  default = "ocid1.compartment.oc1..aaaaaaaal7tfqsnyqix5et7xdt6i2x2ycifn6feuaiqcedqb24whdaorfbjq"
  }
 

#######################
#  net-subnet  cidr   #
#######################

variable "vcn_cidr" {
  default =  "10.253.51.0/24"

}

variable "net_cidr_private" {
  default = "10.253.51.0/26"
}

variable "net_cidr_private_lb" {
  default = "10.253.51.64/26"
}

variable "net_cidr_public" {
  default = "10.253.51.128/26"
}

variable "net_cidr_public_lb" {
  default = "10.253.51.192/26"

}

############

variable "InstanceShape" {
  default = "VM.Standard.E5.Flex"
}

variable "ImageID" {
  # Oracle-Linux-8.10-2024.11.30-0
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaagmkvyc3fldn2lfhvrkyxsmfcemlx2ywrseu3uqio7n7a4vebpcwq"
}

variable "ssh_public_key_elastic" {
  # ssh public key elastic
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3OelZXlgxSBMSHdb7dDjcvyVZZjU81y/p3WM2DutsOHc3uD8f+FE7MMqhS/lPJcyCjCs1ubliQAwwZ46ZglzSEQ1Q9KqgWCtoiuzwXHWUMZ8cFMCI5pYk9MahIy4KTWQJvhUUyxTbHa2CK7gExBxURbgeXT2OPVAmO0zHaznDP4kuyZj58vt+eU6i6PK/t+eL931p55ryiNTlr4Mw+Hmmy3vbUVZ2oBWbmVy1IVw/cHkSliXv+lg1mMOehEc1cEHRq07IHEHmYYodIFJBfB5gZnYUseM+/zlB1DvDD2hcTmZOWNDzfC1ZjrlBm0InvT8VMr63+fWcgcbZElMGbEyJ ssh-key-2025-01-29"

}

#######################
# availability domain #
#######################

variable "availability_domain_1" {
  # Oracle-Linux-8.10-2024.11.30-0
  default = "ocid1.availabilitydomain.oc1..aaaaaaaalcdcbl7u6akbmkojxhrozpj2v7yavqqydkj3ytyjbt47lnoqnm2q"
}

variable "availability_domain_2" {
  # Oracle-Linux-8.10-2024.11.30-0
  default = "ocid1.availabilitydomain.oc1..aaaaaaaaa2artt5wizbqvwl3rgptylx2l7jqbnyv4dygcfvlrd3dphvi3mdq"
}

variable "availability_domain_3" {
  # Oracle-Linux-8.10-2024.11.30-0
  default = "ocid1.availabilitydomain.oc1..aaaaaaaaiifj24st3w4j7cowuo3pmqcuqwjapjv435vtjmgh5j7q3flguwna"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}


#data "oci_identity_availability_domain" "ad_1" {
#  compartment_id =  var.tenancy_ocid
  #compartment_id = "ooid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
#  ad_number      = "1"
#}

#data "oci_identity_availability_domain" "ad_2" {
#  #compartment_id = "ocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
#  compartment_id =  var.tenancy_ocid
#  ad_number      = "2"
#}

#data "oci_identity_availability_domain" "ad_3" {
  #compartment_id = "ocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
#  compartment_id =  var.tenancy_ocid
#  ad_number      = "3"
#}