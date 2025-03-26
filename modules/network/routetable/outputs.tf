output "network_private_route_table_id" {
  value = oci_core_route_table.network_private.id
  description = "The ID of the private route table for the network"
}

output "network_public_route_table_id" {
  value = oci_core_route_table.network_public.id
  description = "The ID of the public route table for the network"
}