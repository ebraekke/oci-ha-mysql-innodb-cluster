
###########################################################################
# OUTPUTs
###########################################################################

output "rm_private_endpoint_ocid" {
  value = module.rm.rm_private_endpoint.id
}

# Yes want to export, show with terraform output -json ssh_public_key
output "ssh_public_key" {
  value = data.tls_public_key.ssh_public_key.public_key_openssh
  sensitive = true
}
