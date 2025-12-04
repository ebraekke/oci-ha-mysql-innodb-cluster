
# variables for readbility in complex statements
locals {
  user_data_base64_standard = filebase64("${path.module}/templates/standard.tpl")

  # Use this domain (zone)
  avadom_name = data.oci_identity_availability_domain.ad.name

  # fault domains for chosen AD (zone)
  faldom_list  = data.oci_identity_fault_domains.ad_fds.fault_domains
  faldom_count = length(local.faldom_list)
}
