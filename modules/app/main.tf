
resource "oci_core_instance" "instance_app" {
  count               = var.instance_count

  availability_domain = var.avadom_name

  # index to entry, lookup to field
  fault_domain        = lookup(var.faldom_list[count.index%var.faldom_count], "name")

  compartment_id      = var.compartment_ocid

  shape               = var.shape
  shape_config {
    memory_in_gbs = var.memory_in_gbs
    ocpus         = var.ocpus
  }

  display_name        = "app${count.index+1}"

	source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

   metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = var.user_data_base64
  }

 create_vnic_details {
    subnet_id                 = var.subnet_ocid
    hostname_label            = "app${count.index+1}"
    assign_public_ip          = true # Needed for agent+plugin to work
  }

  agent_config {
    are_all_plugins_disabled = false

		plugins_config {
			desired_state = "ENABLED"
			name          = "Bastion"
		}
  }

  timeouts {
    create = "60m"
  }
}
