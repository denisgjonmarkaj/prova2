output "vcn_details" {
  value = {
    id          = oci_core_vcn.network.id
    cidr_block  = oci_core_vcn.network.cidr_block #prob not needed
    compartment_id = oci_core_vcn.network.compartment_id #prob not needed
  }
}

output "vcn_private_details" {
  value = {
    id          = oci_core_subnet.network_private.id  
  }
} 
output "private_subnet_id" {
  value = oci_core_subnet.network_private.id
}
output "private_lb_subnet_id" {
  value = oci_core_subnet.network_private_lb.id
}
