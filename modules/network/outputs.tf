###########################################################################
# OUTPUT dns names
###########################################################################
output "app_inside_net" {
  value = oci_core_subnet.app.subnet_domain_name
}

output "db_inside_net" {
  value = oci_core_subnet.db.subnet_domain_name
}

###########################################################################
# OUTPUT ocids of subnets
###########################################################################
output "lbr_subnet_ocid" {
  value = oci_core_subnet.lbr.id
} 

output "bastion_subnet_ocid" {
  value = oci_core_subnet.bastion.id
} 

output "app_subnet_ocid" {
  value = oci_core_subnet.app.id
} 

output "db_subnet_ocid" {
  value = oci_core_subnet.db.id
} 

