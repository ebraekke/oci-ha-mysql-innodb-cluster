
# Variables
variable "set_name" {
    description = "The name of or role of this set, used as base for naming, typicall test/dev/qa"
}

variable "compartment_ocid"     {
    description = "ocid of compartment"
}

variable "vcn_ocid"             {
    description = "ocid of VCN"
}

variable "db_subnet_ocid"          {
    description = "ocid of (private) subnet to host InnoDB cluster"
}

variable "app_subnet_ocid"          {
    description = "ocid of (private) subnet to host App tier"
}

variable "bastion_subnet_ocid"  {
    description = "ocid of (public) subnet for bastion host"
}

variable "vault_ocid" {
    description = "ocid of vault"
}

variable "db_user_name" {
    description = "name of admin db user"
    default = "admin"
}

variable "password_ocid" {
    description = "ocid of secret in vault"
}

variable "sshkey_ocid" {
    description = "ocid of sshkey for VMs in vault"
} 

###########################################################################
# Resource counts and shape
###########################################################################
variable "app_count"        { default = "3" }
variable "app_ocpus"        { default = "1" }
variable "app_mem_per_ocpu" { default = "16" }

variable "db_count"         { default = "3" }
variable "db_ocpus"         { default = "1" }
variable "db_mem_per_ocpu"  { default = "16" }

variable "default_shape"    {
    description = "The shape or family to use for VM ceration"
    default = "VM.Standard.E4.Flex"
}

# Set to your pref depending on OS, assumes same OS family (i.e. opc or ubuntu) 
variable "super_user"       { default = "opc" }

# tried but did not work properly, abondoning
# Canonical-Ubuntu-24.04-2025.09.22-0
# eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaomylr6kmnysurndo37lzq2x2q5teoyoa3oaruqrzfnnb7h5k45hq"

variable "db_image_ocid_map" {
  # Oracle-Linux-10.0-2025.09.16-0                         
  type = map
  default = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaajovmusdfe7lkfsv3fzzn44ac7t35htmzzmnyaawdl4yznw3xdpfa"
  }
}

variable "app_image_ocid_map" {
  # Oracle-Linux-10.0-2025.09.16-0                                      
  type = map
  default = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaajovmusdfe7lkfsv3fzzn44ac7t35htmzzmnyaawdl4yznw3xdpfa"
  }
}


###########################################################################
# Details related to account/identity (local_provider.tf) and book keeping
###########################################################################
variable "region"               {}

variable "oci_cli_profile"      {
    default     = "nosefra"
    description = "name of oci cli profile used for session based auth"
}
variable "tenancy_ocid"         {}
