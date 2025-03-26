output "service_gateway" {
  value = oci_core_service_gateway.service_gateway[0].id
}

output "nat_gateway_private" {
  value = oci_core_nat_gateway.nat_gateway.id
}

output "internet_gateway" {
  value = oci_core_internet_gateway.internet_gateway.id
}