
resource "oci_core_vcn" "this" {
  cidr_block     = var.vcn_cidr
  dns_label      = "hainnodb"
  compartment_id = var.compartment_ocid
  display_name   = "HA InnoDB Network"
}

resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "nat_gateway"
}

resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.compartment_ocid
  display_name   = "ig"
  vcn_id         = oci_core_vcn.this.id
}

# LBR

resource "oci_core_route_table" "lbr" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "lbr rt"

  # TODO: Is this correct? 
  route_rules {
    destination       = local.anywhere
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

resource "oci_core_security_list" "lbr" {
  compartment_id = var.compartment_ocid
  display_name   = "lbr sec list"
  vcn_id         = oci_core_vcn.this.id

  ingress_security_rules {
    source   = local.anywhere
    protocol = local.tcp_protocol

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    source   = local.anywhere
    protocol = local.tcp_protocol

    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination = var.vcn_cidr
    protocol    = local.tcp_protocol

    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    destination = var.vcn_cidr
    protocol    = local.tcp_protocol

    tcp_options {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_subnet" "lbr" {
  cidr_block          = local.lbr_subnet_prefix
  display_name        = "lbr subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.this.id
  route_table_id      = oci_core_route_table.lbr.id

  security_list_ids = [
    oci_core_security_list.lbr.id,
  ]

  dns_label                  = "lbr"
  prohibit_public_ip_on_vnic = false
}


# BASTION
resource "oci_core_route_table" "bastion" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "bastion rt"

  route_rules {
    destination       = local.anywhere
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

resource "oci_core_security_list" "bastion" {
  compartment_id = var.compartment_ocid
  display_name   = "bastion sec list"
  vcn_id         = oci_core_vcn.this.id

  ingress_security_rules {
    source   = local.anywhere
    protocol = local.tcp_protocol

    tcp_options {
      min = 22
      max = 22
    }
  }

  dynamic "egress_security_rules" {
    for_each = [22, 3306, 33060]
    content {
      destination = var.vcn_cidr
      protocol    = local.tcp_protocol

      tcp_options {
        min = egress_security_rules.value
        max = egress_security_rules.value
      }
    }
  }
}

resource "oci_core_subnet" "bastion" {
  cidr_block          = local.bastion_subnet_prefix
  display_name        = "bastion subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.this.id
  route_table_id      = oci_core_route_table.bastion.id

  security_list_ids = [
    oci_core_security_list.bastion.id,
  ]

  dns_label                  = "bastion"
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_route_table" "web" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "web rt"

  route_rules {
    destination       = local.anywhere
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

# WEB 

resource "oci_core_security_list" "web" {
  compartment_id = var.compartment_ocid
  display_name   = "web sec list"
  vcn_id         = oci_core_vcn.this.id

  ingress_security_rules {
    source   = local.bastion_subnet_prefix
    protocol = local.tcp_protocol

    tcp_options {
      min = 22
      max = 22
    }
  }

  egress_security_rules {
    destination = local.anywhere
    protocol    = local.all_protocols
  }
}

resource "oci_core_subnet" "app" {
  cidr_block          = local.app_subnet_prefix
  display_name        = "app subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.this.id
  route_table_id      = oci_core_route_table.web.id

  security_list_ids = [
    oci_core_security_list.web.id,
  ]

  dns_label                  = "app"
  prohibit_public_ip_on_vnic = true
}

# DB

resource "oci_core_route_table" "db" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "db rt"

  route_rules {
    destination       = local.anywhere
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

resource "oci_core_security_list" "db" {
  compartment_id = var.compartment_ocid
  display_name   = "db sec list"
  vcn_id         = oci_core_vcn.this.id

  dynamic "ingress_security_rules" {
    for_each = [3306, 33060]
    content {
    source   = local.bastion_subnet_prefix
    protocol = local.tcp_protocol

      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }
}


resource "oci_core_subnet" "db" {
  cidr_block          = local.db_subnet_prefix
  display_name        = "db subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.this.id
  route_table_id      = oci_core_route_table.db.id

  security_list_ids = [
    oci_core_security_list.db.id,
  ]

  dns_label                  = "db"
  prohibit_public_ip_on_vnic = true
}
