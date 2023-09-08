
resource "local_file" "private_key_file" {
  filename = "${path.module}/config/ssh-key"
  content  = base64decode(data.oci_secrets_secretbundle.sshkey.secret_bundle_content[0]["content"])
}

/*
resource "local_file" "ssh_config_file" {
  filename = "${path.module}/config/ssh-config"
  content  = "${data.template_file.ssh_config.rendered}"
}
*/