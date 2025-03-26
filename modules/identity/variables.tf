variable "tenancy_ocid" {
  description = "OCID del tenancy Oracle Cloud"
  type        = string
}

variable "tag_namespace_name" {
  description = "Nome del namespace per i tag definiti"
  type        = string
  default     = "BMW"
}

variable "tag_namespace_description" {
  description = "Descrizione del namespace per i tag definiti"
  type        = string
  default     = "Namespace per il progetto BMW"
}