variable "vcn_details" {}

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

#variable "availability_domain" {
 # type        = string
#}