
###########################################################################
# OUTPUT ips
###########################################################################

output "app_private_ips" {
  value = oci_core_instance.instance_app.*.private_ip
}

output "app_ocid_list" {
  value = oci_core_instance.instance_app.*.id
}
