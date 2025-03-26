terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}

resource "oci_identity_tag_namespace" "project_namespace" {
  compartment_id = var.tenancy_ocid
  description    = var.tag_namespace_description
  name           = var.tag_namespace_name
}

resource "oci_identity_tag" "environment_tag" {
  description     = "Ambiente di deployment"
  name            = "Environment"
  tag_namespace_id = oci_identity_tag_namespace.project_namespace.id
  
}

resource "oci_identity_tag" "project_tag" {
  description     = "Nome del progetto"
  name            = "Project"
  tag_namespace_id = oci_identity_tag_namespace.project_namespace.id
}

resource "oci_identity_tag" "managed_by_tag" {
  description     = "Strumento di gestione"
  name            = "ManagedBy"
  tag_namespace_id = oci_identity_tag_namespace.project_namespace.id
  
}

resource "oci_identity_tag" "component_tag" {
  description     = "Componente dell'infrastruttura"
  name            = "Component"
  tag_namespace_id = oci_identity_tag_namespace.project_namespace.id
}

resource "oci_identity_tag" "compartment_tag" {
  description     = "Tipo di compartment logico"
  name            = "Compartment"
  tag_namespace_id = oci_identity_tag_namespace.project_namespace.id

}