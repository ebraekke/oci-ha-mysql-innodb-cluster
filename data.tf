# Get a list of Availability Domains (ADs)
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# get AD1
data "oci_identity_availability_domain" "ad1" {
    compartment_id = var.tenancy_ocid
    ad_number = "1"
}

# Get FDs in AD1
data "oci_identity_fault_domains" "ad1_fds" {
    availability_domain = data.oci_identity_availability_domain.ad1.name
    compartment_id = var.tenancy_ocid
}

# Get content of private ssh key
data "oci_secrets_secretbundle" "sshkey" {
    secret_id = var.sshkey_ocid
}

# Generate public key 
data "tls_public_key" "ssh_public_key" {
  private_key_openssh = base64decode(data.oci_secrets_secretbundle.sshkey.secret_bundle_content[0]["content"])
}


# Create ssh config file
data "template_file" "ssh_config" {
  template = file("${path.module}/templates/ssh_config.tpl")
  vars = {
    private_key_path       = pathexpand(local_file.private_key_file.filename)
    destination_ssh_user   = "${var.super_user}"
    destination_hostname   = "${module.app.app_hostname_labels[0]}"
    destination_private_ip = "${module.app.app_private_ips[0]}"
  }
}
