
resource "oci_database_tools_database_tools_connection" "mysql_connection" {

    count = var.this_count

    compartment_id  = var.compartment_ocid

    display_name    = "${var.connection_base_name}${count.index+1}"
    type = "MYSQL"

    connection_string = "mysql://${var.mysql_ipaddress_list[count.index]}:${var.mysql_port}"
    
    private_endpoint_id = var.priv_endpoint_ocid

    user_name = var.db_user_name
    user_password {
        secret_id   = var.db_password_ocid
        value_type  = "SECRETID"
    }
}
