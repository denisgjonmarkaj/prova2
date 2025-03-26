output "tag_namespace_id" {
  description = "L'OCID del namespace per i tag definiti"
  value       = oci_identity_tag_namespace.project_namespace.id
}

output "tag_namespace_name" {
  description = "Il nome del namespace per i tag definiti"
  value       = oci_identity_tag_namespace.project_namespace.name
}

output "environment_tag_name" {
  description = "Il nome completo del tag Environment"
  value       = "${oci_identity_tag_namespace.project_namespace.name}.${oci_identity_tag.environment_tag.name}"
}

output "project_tag_name" {
  description = "Il nome completo del tag Project"
  value       = "${oci_identity_tag_namespace.project_namespace.name}.${oci_identity_tag.project_tag.name}"
}

output "managed_by_tag_name" {
  description = "Il nome completo del tag ManagedBy"
  value       = "${oci_identity_tag_namespace.project_namespace.name}.${oci_identity_tag.managed_by_tag.name}"
}

output "component_tag_name" {
  description = "Il nome completo del tag Component"
  value       = "${oci_identity_tag_namespace.project_namespace.name}.${oci_identity_tag.component_tag.name}"
}

output "compartment_tag_name" {
  description = "Il nome completo del tag Compartment"
  value       = "${oci_identity_tag_namespace.project_namespace.name}.${oci_identity_tag.compartment_tag.name}"
}