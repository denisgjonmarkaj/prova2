variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
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
  default     = "ocid1.tenancy.oocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
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
    description = "Network parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaavsh27mzzzppus7xhx6o3nlypoqr6n56eeb2cqkfo5x4ewdo2bbza"
}
variable "compartment_network-prd_ocid" {
  description = "Network prd compartment"
  default = "ocid1.compartment.oc1..aaaaaaaagtwuuk4w2h3lkqkfjoejy4zsix77ena5lkccdpxl4h5ughpq2mbq"
  }


variable "parent_compartment_compute" {
    description = "Compute parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaacg4jc5ttpn2dgcs6rsyyxtekbg7zmqvsr7soedyprac4cxtw2oia"
}
variable "compartment_compute-prd_ocid" {
  description = "Compute qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaa255aseguswcu5gdtnandja6kcmzv7cafigd63yp5fmuur4by7z2a"
  }


variable "parent_compartment_db" {
    description = "DB parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaacg4jc5ttpn2dgcs6rsyyxtekbg7zmqvsr7soedyprac4cxtw2oia"
}
variable "compartment_db-prd_ocid" {
  description = "Compute qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaa7hjjt2hc6oljmbgha3n2pkglqynhxs5h2z46z4427ppcdy4zumka"
  }

variable "parent_compartment_identity" {
    description = "Identity parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaaqm44ulgpdsm4w5ffprlng4k247ehaypcoqwynwqzbrbcdkgxuxxq"
}
variable "compartment_identity-prd_ocid" {
  description = "Identity qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaafgrex6jydhpjocd6j2caurenoyu4ulekz32yjzaymcz5zd7wvoea"
  }

variable "parent_compartment_microservices" {
    description = "Microservices parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaarlsaw5w444z7ropjhglpmk7waj2tq4isowbo2a47qjxivmxpszka"
}
variable "compartment_microservices-prd_ocid" {
  description = "Microservices qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaaevl3iky6dn4ja3y3hk3d3fxu462eqnctibxzu2xv6leljqvksl4q"
  }


variable "parent_compartment_storage" {
    description = "Storage parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaao5iyftyknrcwizfykaehzq2nglx6ggtgvakyj56z5kurdy4wk2dq"
}
variable "compartment_storage-prd_ocid" {
  description = "Storage qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaaphlzttjne3dm76b2ib34b45fpksw4wtqomamw5jl3oxxoctscs5a"
  }





#######################
#  net-subnet  cidr   #
#######################

variable "vcn_cidr" {
  default =  "10.253.49.0/24"

}

variable "net_cidr_private" {
  default = "10.253.49.0/26"
}

variable "net_cidr_private_lb" {
  default = "10.253.49.64/26"
}

variable "net_cidr_public" {
  default = "10.253.49.128/26"
}

variable "net_cidr_public_lb" {
  default = "10.253.49.192/26"

}



#######################
# availability domain #
#######################

data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-1" {
  compartment_id = "ocid1.tenancy.oocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
  ad_number      = "1"
}

data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-2" {
  compartment_id = "ocid1.tenancy.oocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
  ad_number      = "2"
}

data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-3" {
  compartment_id = "ocid1.tenancy.oocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
  ad_number      = "3"
}



#######################
    # Kubernetes #
#######################


variable "kubernetes_version" {
  description = "Versione di Kubernetes per l'ambiente staging"
  type        = string
  default     = "v1.31.1"
}

variable "node_image_id" {
  description = "L'OCID dell'immagine dei nodi"
  type        = string
  default     = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaagmkvyc3fldn2lfhvrkyxsmfcemlx2ywrseu3uqio7n7a4vebpcwq"
}