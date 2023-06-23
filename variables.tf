
# Input variables
variable "vcn_cidr"           { default = "10.0.0.0/16" }
variable "subnet_cidr_offset" { default = 8 }

# Variables
variable "set_name" {
    description = "The name of or role of this set, used as base for naming, typicall test/dev/qa"
}

variable "compartment_ocid"     {
    description = "ocid of compartment"
}

###########################################################################
# Resource counts and shape
###########################################################################
variable "web_count"        { default = "3" }
variable "web_ocpus"        { default = "1" }
variable "web_mem_per_ocpu" { default = "16" }

###########################################################################
# Details for VMs
###########################################################################
variable "ssh_public_key"   {}

/*
###########################################################################
# Details related to account/identity (provider.tf)
###########################################################################
variable "user_ocid"        {}
variable "fingerprint"      {}
variable "private_key_path" {}
*/ 

# Set to your pref depending on OS, assumes same OS family (i.e. opc or ubuntu) 
variable "super_user"       { default = "opc" }

/*
variable "default_shape"    {}
variable "web_image_ocid"   {}
*/

###########################################################################
# Details related to account/identity (local_provider.tf) and book keeping
###########################################################################
variable "region"               {}

variable "oci_cli_profile"      {
    default     = "nosefra"
    description = "name of oci cli profile used for session based auth"
}
variable "tenancy_ocid"         {}
