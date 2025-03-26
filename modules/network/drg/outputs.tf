#output "DRG-siav-bmw" {
#  value = oci_core_drg.DRG-siav-bmw.id
#}

# Output per verificare se il DRG esiste
output "DRG-siav-bmw" {
  value = length(data.oci_core_drgs.DRG-siav-bmw.drgs) > 0 ? data.oci_core_drgs.DRG-siav-bmw.drgs[0].id : null
}

          
output "ePress-VPN" {
  value = length(data.oci_core_cpes.ePress-VPN.cpes) > 0 ? data.oci_core_cpes.ePress-VPN.cpes[0].id  : null
}
