variable "vcn_details" {
  description = "Dettagli della VCN a cui collegare il cluster OKE"
  type = object({
    id = string
    cidr_block = string
    compartment_id = string
  })
}

variable "nsg_ids" {
  type = list(string)
}

variable "private_subnet_id" {}
variable "private_lb_subnet_id" {}

variable "compartment_id" {
  description = "OCID del compartment per il cluster OKE"
  type        = string
}

variable "kubernetes_version" {
  description = "La versione di Kubernetes da utilizzare"
  type        = string
  default     = "v1.31.1" 
}

variable "node_image_id" {
  description = "L'OCID dell'immagine da usare per i nodi"
  type        = string
  default     = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaagmkvyc3fldn2lfhvrkyxsmfcemlx2ywrseu3uqio7n7a4vebpcwq"
}

variable "node_shape" {
  description = "Lo shape delle istanze del node pool"
  type        = string
  default     = "VM.Standard.E3.Flex"
}

variable "node_ocpus" {
  description = "Numero di OCPUs per ogni nodo"
  type        = number
  default     = 1
}

variable "node_memory" {
  description = "Memoria in GB per ogni nodo"
  type        = number
  default     = 8
}

variable "tenancy_ocid" {
  description = "OCID del tenancy"
  type        = string
}

variable "freeform_tags" {
  description = "Free-form tags da applicare alle risorse"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment (development, staging, production)"
  type        = string
}

variable "tag_namespace_name" {
  description = "Nome del namespace per i tag definiti"
  type        = string
  default     = "BMW"
}

variable "component_name" {
  description = "Nome del componente per i tag"
  type        = string
  default     = "kubernetes"
}

variable "availability_domain_name" {
  description = "Nome dell'availability domain per i nodi del cluster"
  type        = string
}

variable "ad_number" {
  description = "Il numero dell'Availability Domain da utilizzare (1, 2 o 3)"
  type        = number
  default     = 1
}