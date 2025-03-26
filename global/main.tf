terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.23.0" # Check compatibility version
    }
  }
}

provider "oci" {
  alias               = "bootstrap"
  auth                = "SecurityToken"
  config_file_profile = "BMW-TF"
  region              = "eu-frankfurt-1"
}

data "oci_secrets_secretbundle" "private_key" {
  provider  = oci.bootstrap
  secret_id = var.admin_user_pk
}