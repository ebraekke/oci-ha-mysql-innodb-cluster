
/*
module "rm" {
    source              = "./modules/rm"

    compartment_ocid    = var.compartment_ocid
    vcn_ocid            = var.vcn_ocid
    subnet_ocid         = var.bastion_subnet_ocid
    display_name        = "HA InnoDB RM Private endpoint"
}

module "app" {
    source              = "./modules/app"

    instance_count      = var.app_count
    compartment_ocid    = var.compartment_ocid
    ssh_public_key      = data.tls_public_key.ssh_public_key.public_key_openssh
    user_data_base64    = local.user_data_base64_standard
    shape               = var.default_shape
    ocpus               = var.app_ocpus
    memory_in_gbs       = var.app_mem_per_ocpu * var.app_ocpus
    avadom_name         = local.avadom_name
    faldom_list         = local.faldom_list
    faldom_count        = local.faldom_count
    subnet_ocid         = var.app_subnet_ocid
    image_ocid          = var.app_image_ocid_map[var.region]
    super_user          = var.super_user
    config_file         = "${path.module}/config/inventory_app"
    sshkey_file         = "${path.module}/config/ssh-key"
}
*/

module "db" {
    source              = "./modules/db"

    instance_count      = var.db_count
    compartment_ocid    = var.compartment_ocid
    ssh_public_key      = data.tls_public_key.ssh_public_key.public_key_openssh
    user_data_base64    = local.user_data_base64_standard
    shape               = var.default_shape
    ocpus               = var.db_ocpus
    memory_in_gbs       = var.db_mem_per_ocpu * var.db_ocpus
    avadom_name         = local.avadom_name
    faldom_list         = local.faldom_list
    faldom_count        = local.faldom_count
    subnet_ocid         = var.db_subnet_ocid
    image_ocid          = var.db_image_ocid_map[var.region]
}
