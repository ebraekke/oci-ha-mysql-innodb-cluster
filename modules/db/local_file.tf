###########################################################################
# ANSIBLE file(s)
###########################################################################

/*
resource "local_file" "ansible_inventory_db" {

  content = "[db]\n${join("\n",
            formatlist(
              "%s.%s ansible_user=%s",
              oci_core_instance.instance_db.*.hostname_label,
              oci_core_subnet.db.subnet_domain_name,
              var.super_user
            ))}"


  filename = "${path.module}/config/${var.set_name}_inventory_db"
}

*/
