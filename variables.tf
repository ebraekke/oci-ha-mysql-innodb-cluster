
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

# Switch to:
# VM.Standard.A1.Flex 
# VM.Standard.A2.Flex 
#
# A1 is cheaper , may use for APPS and light-weight stuff
# that is:
# 0.01 on cpu and 0.0015 on RAM
# vs
# 0.014 on cpu and 0.002 on RAM
#
# Note on pricing:
# https://www.oracle.com/cloud/compute/virtual-machines/pricing/
#  1 OCPU on Arm A2 CPU Architecture = 2 cores on A2 or 2vCPUs
variable "default_shape"    {
    description = "The shape or family to use for VM ceration"
    # default = "VM.Standard.E4.Flex"
    default = "VM.Standard.A1.Flex"
}

# Set to your pref depending on OS, assumes same OS family (i.e. opc or ubuntu) 
variable "super_user"       { default = "opc" }

# tried but did not work properly, abondoning

/*
| Oracle-Linux-8.10-2025.10.23-0  | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakjvbifnkpz5annjgb74ax7sdlguciylnt4yqas4ncjdiu7fzllpa |

| Oracle-Linux-8.10-aarch64-2025.10.23-0              | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5l2ht46sdih2j2vrtugeqmi5opn45ostngzhe4z5rtdct7zcbmta |

| Canonical-Ubuntu-22.04-aarch64-2025.10.31-0         | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaab4imietimnkcafuesd47z6xzp3byqxflevxub5bonjlsiekopkjq |
| Canonical-Ubuntu-22.04-Minimal-aarch64-2025.10.31-0 | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaao3zgxdgzwgmstkzq2umtnuuqww65vn6af54tz2xelji76u5dlt7q |
*/

/*
Canonical-Ubuntu-22.04-aarch64-2025.10.31-0         
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaab4imietimnkcafuesd47z6xzp3byqxflevxub5bonjlsiekopkjq"

Canonical-Ubuntu-22.04-Minimal-aarch64-2025.10.31-0
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaao3zgxdgzwgmstkzq2umtnuuqww65vn6af54tz2xelji76u5dlt7q"
*/

variable "db_image_ocid_map" {
    type = map
    default = {
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5l2ht46sdih2j2vrtugeqmi5opn45ostngzhe4z5rtdct7zcbmta"
     }
}

variable "app_image_ocid_map" {
    type = map
    default = {
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5l2ht46sdih2j2vrtugeqmi5opn45ostngzhe4z5rtdct7zcbmta"
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
