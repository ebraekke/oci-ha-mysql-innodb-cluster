###########################################################################
# ANSIBLE file(s)
###########################################################################

resource "local_file" "ansible_inventory_app" {


  content = "[app]\n${join("\n",
            formatlist(
              "%s ansible_user=%s ansible_ssh_private_key_file=%s",
              oci_core_instance.instance_app.*.private_ip,
              "opc",
              var.sshkey_file
            ))}"
            
    filename = var.config_file
}
