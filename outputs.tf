
###########################################################################
# OUTPUTs
###########################################################################

# Show ocids for next level module that will do config
output "db_ocids" {
  value = module.db.db_ocid_list
}

# Show ips for next level module that will do config
output "db_ips" {
  value = module.db.db_private_ips
}

## Show domain
output "avadom_name" {
  value = local.avadom_name
}
