
###########################################################################
# OUTPUT test
###########################################################################
output "vnc_ocid" {
  value = module.network.vcn_ocid
}

output "rm_private_endpoint_ocid" {
  value = module.resource-manager.rm_private_endpoint.id
}

