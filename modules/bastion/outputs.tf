
###########################################################################
# OUTPUT ips
###########################################################################


output "bastion_public_ip_list" {
  value = oci_core_instance.instance_bastion.*.public_ip
}
