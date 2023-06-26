
module "network" {
    source              = "./modules/network"

    compartment_ocid    = var.compartment_ocid
    vcn_cidr            = var.vcn_cidr
    subnet_cidr_offset  = var.subnet_cidr_offset
}

module "resource-manager" {
    source              = "./modules/resource-manager"

    compartment_ocid    = var.compartment_ocid
    vcn_ocid            = module.network.vcn_ocid
    subnet_ocid         = module.network.bastion_subnet_ocid
    display_name        = "HA InnoDB RM Private endpoint"
}

/*
module "app" {
    source              = "./modules/app"

    instance_count      = 1  #  var.web_count
    compartment_ocid    = var.compartment_ocid
    ssh_public_key      = var.ssh_public_key
    user_data_base64    = local.user_data_base64_standard
    shape               = "VM.Standard.E4.Flex" # var.default_shape
    ocpus               = "1" # var.web_ocpus
    memory_in_gbs       = "16" # var.web_mem_per_ocpu * var.web_ocpus
    avadom_name         = local.avadom_name
    faldom_list         = local.faldom_list
    faldom_count        = local.faldom_count
    subnet_ocid         = module.network.web_subnet_ocid
    image_ocid          = var.web_image_ocid
}
*/