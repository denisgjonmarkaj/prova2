variable "vcn_id" {
  description = "L'ID della VCN da associare al gateway internet"
  type        = string
}

variable "vcn_private_id" {
  description = "L'ID della subnet privata per le istanze ElasticSearch"
  type        = string
} 

variable "compartment_compute_id" {
  description = "L'OCID del compartment dove verranno create le risorse compute"
  type        = string
}

variable "compartment_storage_id" {
  description = "L'OCID del compartment dove verranno create le risorse storage"
  type        = string
}

variable "InstanceShape" {
  description = "Shape dell'istanza compute (es. VM.Standard.E5.Flex)"
  type        = string
  default     = "VM.Standard.E5.Flex"
}

variable "ImageID" {
  description = "L'OCID dell'immagine del sistema operativo"
  type        = string
}

variable "environment" {
  description = "L'ambiente (es. dev, staging, prod)"
  type        = string
}

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

variable "nfs_service_nsg_id" {
  description = "ID del network security group per il servizio NFS"
  type        = string
}

variable "ssh_public_key_elastic" {
  description = "Chiave pubblica SSH per ElasticSearch"
  type        = string
}

variable "tag_namespace_name" {
  description = "Nome del namespace per i tag definiti"
  type        = string
  default     = "BMW"
}

variable "tenancy_ocid" {
  description = "OCID del tenancy OCI"
  type        = string
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