
resource "oci_resourcemanager_private_endpoint" "rm_private_endpoint" {
    compartment_id                              = var.compartment_ocid
    display_name                                = var.display_name
    subnet_id                                   = var.subnet_ocid
    vcn_id                                      = var.vcn_ocid
    is_used_with_configuration_source_provider  = false 
}
