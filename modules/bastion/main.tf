resource "oci_bastion_session" "managed_session_for_db" {

    count = var.count 

    bastion_id = oci_bastion_bastion.test_bastion.id

    key_details {
        public_key_content = var.session_key_details_public_key_content
    }
    target_resource_details {
        session_type = "MANAGED_SSH"

        target_resource_id                          = var.compute_ocid
        target_resource_operating_system_user_name  ="opc"
        target_resource_port                        = "22"

        # Needed when using managed? 
        target_resource_private_ip_address = data.ip_of_compute
    }

    #Optional
    display_name           = "ops-session"
    key_type               = "PUB"
    session_ttl_in_seconds = data.ttl_from_bastion
}