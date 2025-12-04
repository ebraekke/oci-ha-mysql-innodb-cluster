# Get a list of Availability Domains (ADs)
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Use this AD (zone)
data "oci_identity_availability_domain" "ad" {
    compartment_id = var.tenancy_ocid
    ad_number = var.deploy_to_zone
}

# Get FDs in AD1
data "oci_identity_fault_domains" "ad_fds" {
    availability_domain = data.oci_identity_availability_domain.ad.name
    compartment_id = var.tenancy_ocid
}

/*
# get AD2
data "oci_identity_availability_domain" "ad2" {
    compartment_id = var.tenancy_ocid
    ad_number = "2"
}

# Get FDs in AD2
data "oci_identity_fault_domains" "ad2_fds" {
    availability_domain = data.oci_identity_availability_domain.ad2.name
    compartment_id = var.tenancy_ocid
}
*/

# Get content of private ssh key
data "oci_secrets_secretbundle" "sshkey" {
    secret_id = var.sshkey_ocid
}

# Generate public key 
data "tls_public_key" "ssh_public_key" {
  private_key_openssh = base64decode(data.oci_secrets_secretbundle.sshkey.secret_bundle_content[0]["content"])
}

