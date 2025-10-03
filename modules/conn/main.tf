
resource "oci_database_tools_database_tools_connection" "mysql_connection" {
    compartment_id  = var.compartment_ocid
    display_name    = var.connection_name
    type = "MYSQL"

    connection_string = "mysql://${var.mysql_ipaddress}:${var.mysql_port}"
    
    private_endpoint_id = var.priv_endpoint_ocid

/* 
Not needed remove later

    related_resource {
        entity_type = "MYSQLDBSYSTEM"
        identifier  = var.mysql_db_ocid
    }
*/

    user_name = var.db_user_name
    user_password {
        secret_id   = var.db_password_ocid
        value_type  = "SECRETID"
    }
}
