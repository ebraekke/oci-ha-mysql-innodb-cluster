
###########################################################################
# OUTPUTs
###########################################################################

/*
output "rm_private_endpoint_ocid" {
  value = module.rm.rm_private_endpoint.id
}
*/ 

# Yes want to export, show with terraform output -json ssh_public_key
output "ssh_public_key" {
  value = data.tls_public_key.ssh_public_key.public_key_openssh
  sensitive = true
}

# Show ips for next level module that will do config
output "db_ip_addresses" {
  value = module.db.db_private_ips
}

# Show ips for next level module that will do config
output "db_ocids" {
  value = module.db.db_ocid_list
}

