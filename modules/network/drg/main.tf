terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "6.23.0"
    }
  }
}
#######################
#        DRG          #
#######################



# Cerca il DRG esistente con nome specifico
data "oci_core_drgs" "DRG-siav-bmw" {
  compartment_id = var.parent-compartment-network
  #display_name   = "DRG-siav-bmw" # Nome del DRG esistente
}

# Crea il DRG solo se non esiste
resource "oci_core_drg" "DRG-siav-bmw" {
  count        = length(data.oci_core_drgs.DRG-siav-bmw.drgs) == 0 ? 1 : 0
  compartment_id = var.parent-compartment-network
  display_name   = "DRG-siav-bmw"
}

# Determina l'ID del DRG (esistente o appena creato)
locals {
  DRG-siav-bmw = length(data.oci_core_drgs.DRG-siav-bmw.drgs) > 0 ? data.oci_core_drgs.DRG-siav-bmw.drgs[0].id : oci_core_drg.DRG-siav-bmw[0].id
}

#################################################################################################################################################################
#################################################################################################################################################################

#######################
#        CPE          #
#######################


# Cerca il CPE esistente con nome specifico

data "oci_core_cpes" "ePress-VPN" {
  compartment_id = var.parent-compartment-network
}

# Crea il DRG solo se non esiste

resource "oci_core_cpe" "ePress-VPN" {
  count               = length(data.oci_core_cpes.ePress-VPN.cpes) == 0 ? 1 : 0
  compartment_id      =  var.parent-compartment-network
  cpe_device_shape_id = "15addf76-6ecd-4a76-a1e7-527edd848471"
  ip_address          = "81.27.128.135"
  display_name        = "ePress-VPN"
}

# Determina l'ID del CPE (esistente o appena creato)

locals {
 ePress-VPN = length(data.oci_core_cpes.ePress-VPN.cpes) > 0 ? data.oci_core_cpes.ePress-VPN.cpes[0].id : oci_core_cpe.ePress-VPN[0].id
}

#################################################################################################################################################################
#################################################################################################################################################################
#######################
#        IPSec           #
#######################


# Cerca ipsec esistente con nome specifico

data "oci_core_ipsec_connections" "ePress-VPN" {
  compartment_id = var.parent-compartment-network
}

# Crea ipsec solo se non esiste
resource "oci_core_ipsec" "ePress-VPN" {
  count                     = length(data.oci_core_ipsec_connections.ePress-VPN.connections) == 0 ? 1 : 0
  compartment_id            = var.parent-compartment-network
  cpe_id                    = local.ePress-VPN
  cpe_local_identifier      = "81.27.128.135"
  cpe_local_identifier_type = "IP_ADDRESS"
  display_name              = "ePress-VPN"
  drg_id                    = local.DRG-siav-bmw
  static_routes = [
    "10.2.5.0/24",
  ]
}