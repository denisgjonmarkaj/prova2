variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
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
    description = "Network parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaavsh27mzzzppus7xhx6o3nlypoqr6n56eeb2cqkfo5x4ewdo2bbza"
}
variable "compartment_network-qa_ocid" {
  description = "Network qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaa242igehzmabfkw7eyh2werc7wp73zqgecdlyeuk3t2qkkyjuz5ga"
  }


variable "parent_compartment_compute" {
    description = "Compute parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaacg4jc5ttpn2dgcs6rsyyxtekbg7zmqvsr7soedyprac4cxtw2oia"
}
variable "compartment_compute-qa_ocid" {
  description = "Compute qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaai7na6tcql6mqhzug35k6afbtwl5spp37jctqa2crjcxgiyavpvca"
  }


variable "parent_compartment_db" {
    description = "DB parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaabtkuerzc54dphi2v7awiyv5gpcpwfq34wxkjwtydwq46qky3cxma"
}
variable "compartment_db-qa_ocid" {
  description = "Compute qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaarynw2fvd4y5vmrldiq7mt6stfdzzkrgztn7jeu2pxdz4ygeps7aa"
  }

variable "parent_compartment_identity" {
    description = "Identity parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaaqm44ulgpdsm4w5ffprlng4k247ehaypcoqwynwqzbrbcdkgxuxxq"
}
variable "compartment_identity-qa_ocid" {
  description = "Identity qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaalxppitzuyn6nrpj6zqh6y4jggvhxi64zabkt5clrdvnw7p3vm5va"
  }

variable "parent_compartment_microservices" {
    description = "Microservices parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaarlsaw5w444z7ropjhglpmk7waj2tq4isowbo2a47qjxivmxpszka"
}
variable "compartment_microservices-qa_ocid" {
  description = "Microservices qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaaxehdnyc4biwhjzynoyt6xdrtlcjpvhvwqk6spg7ftho2zuep3rsa"
  }


variable "parent_compartment_storage" {
    description = "Storage parent compartment"
    default = "ocid1.compartment.oc1..aaaaaaaao5iyftyknrcwizfykaehzq2nglx6ggtgvakyj56z5kurdy4wk2dq"
}
variable "compartment_storage-qa_ocid" {
  description = "Storage qa compartment"
  default = "ocid1.compartment.oc1..aaaaaaaabqac3qf3kdlowtyxam24up3ci3z3mix5aythjbqennnfs3vz2a5a"
  }


#######################
#  net-subnet  cidr   #
#######################

variable "vcn_cidr" {
  default =  "10.253.50.0/24"

}

variable "net_cidr_private" {
  default = "10.253.50.0/26"
}

variable "net_cidr_private_lb" {
  default = "10.253.50.64/26"
}

variable "net_cidr_public" {
  default = "10.253.50.128/26"
}

variable "net_cidr_public_lb" {
  default = "10.253.50.192/26"

}

#######################
# availability domain #
#######################

#data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-1" {
#  compartment_id = var.tenancy_ocid
#  ad_number      = "1"
#}

#data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-2" {
#  compartment_id = var.tenancy_ocid
#  ad_number      = "2"
#}

#data "oci_identity_availability_domain" "EU-FRANKFURT-1-AD-3" {
#  compartment_id = var.tenancy_ocid
 # ad_number      = "3"
#}



variable "availability_domain_1" {
  #Oracle-Linux-8.10-2024.11.30-0
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


#######################
    # Instance #
#######################

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


variable "compartment-compute_ocid" {
  description = "OCID del compartment per le risorse compute in ambiente QA"
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaa255aseguswcu5gdtnandja6kcmzv7cafigd63yp5fmuur4by7z2a"
}

variable "compartment-storage_ocid" {
  description = "OCID del compartment per le risorse storage in ambiente QA"
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaabqac3qf3kdlowtyxam24up3ci3z3mix5aythjbqennnfs3vz2a5a"
}



variable "postgresql_display_name" {
  description = "Nome visualizzato per il database PostgreSQL"
  type        = string
  default     = "postgresql"
}

variable "postgresql_db_version" {
  description = "Versione di PostgreSQL da utilizzare"
  type        = string
  default     = "14.11"
}

variable "postgresql_shape" {
  description = "Shape per il sistema PostgreSQL"
  type        = string
  default     = "VM.Standard.E5.Flex"
}

variable "postgresql_cpu_core_count" {
  description = "Numero di CPU cores per PostgreSQL"
  type        = number
  default     = 2
}

variable "postgresql_memory_size_in_gbs" {
  description = "Quantità di memoria in GB per PostgreSQL"
  type        = number
  default     = 32
}

variable "postgresql_instance_count" {
  description = "Numero di istanze PostgreSQL"
  type        = number
  default     = 1
}

variable "postgresql_admin_username" {
  description = "Nome utente amministratore per PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "postgresql_admin_password" {
  description = "Password amministratore per PostgreSQL"
  type        = string
  sensitive   = true
}

variable "postgresql_availability_domain" {
  description = "Availability Domain per PostgreSQL"
  type        = string
  default     = "EU-FRANKFURT-1-AD-1"
}


variable "postgresql_is_regionally_durable" {
  description = "Se il sistema PostgreSQL è durevole a livello regionale"
  type        = bool
  default     = true
}

variable "postgresql_backup_policy_kind" {
  description = "Tipo di policy di backup (NONE, DAILY, WEEKLY, MONTHLY)"
  type        = string
  default     = "WEEKLY"
}

variable "postgresql_backup_start_time" {
  description = "Orario di inizio del backup in formato 24 ore (es. '00:30')"
  type        = string
  default     = "00:30"
}

variable "postgresql_backup_retention_days" {
  description = "Numero di giorni di conservazione dei backup"
  type        = number
  default     = 31
}

variable "postgresql_backup_days_of_week" {
  description = "Giorni della settimana per i backup (es. ['SUNDAY'])"
  type        = list(string)
  default     = ["SUNDAY"]
}


#Variables Elasticsearch

variable "elasticsearch_fault_domain" {
  description = "Fault domain per le istanze ElasticSearch"
  type        = string
  default     = "FAULT-DOMAIN-3"
}

variable "elasticsearch_availability_domain" {
  description = "Availability domain per le istanze ElasticSearch"
  type        = string
  default     = "ibtU:EU-FRANKFURT-1-AD-1"
}

variable "elasticsearch_instance_ocpus" {
  description = "Numero di OCPU per istanza ElasticSearch"
  type        = number
  default     = 4
}

variable "elasticsearch_instance_memory" {
  description = "Memoria in GB per istanza ElasticSearch"
  type        = number
  default     = 32
}

variable "elasticsearch_block_volume_size_gb" {
  description = "Dimensione del block volume in GB per ElasticSearch"
  type        = number
  default     = 100
}

variable "elasticsearch_block_volume_vpus" {
  description = "Performance in VPUS per GB per ElasticSearch"
  type        = number
  default     = 10
}

variable "elasticsearch_boot_volume_size_gb" {
  description = "Dimensione del volume di boot in GB per ElasticSearch"
  type        = number
  default     = 100
}

variable "elasticsearch_instance_pool_size" {
  description = "Numero di istanze nel pool ElasticSearch"
  type        = number
  default     = 3
}