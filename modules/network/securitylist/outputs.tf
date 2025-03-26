output "private_security_list_id" {
  description = "The OCID of the private security list"
  value       = oci_core_security_list.network_private.id
}

output "private_lb_security_list_id" {
  description = "The OCID of the private load balancer security list"
  value       = oci_core_security_list.network_private_lb.id
}

output "public_security_list_id" {
  description = "The OCID of the public security list"
  value       = oci_core_security_list.network_public.id
}

output "public_lb_security_list_id" {
  description = "The OCID of the public load balancer security list"
  value       = oci_core_security_list.network_public_lb.id
}

output "kubernetes_services_nsg_id" {
  value = oci_core_network_security_group.kubernetes-services.id
}

output "nfs_service_nsg_id" {
  value = oci_core_network_security_group.nfs-service.id
}

output "postgresql_service_nsg_id" {
  value = oci_core_network_security_group.postgresql_service.id
}