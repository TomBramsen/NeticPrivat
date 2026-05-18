


# Warning
# An LDP cluster can't be created and deleted via Terraform at this time. So when Terraform destroys the resource, it only actually restores it to its initial state.
# https://manager.ca.ovhcloud.com/#/dedicated/dbaas/logs/order

/*
resource "ovh_dbaas_logs_cluster" "my_logs" {
  service_name = var.ovh_tenantid
  #region       = var.ovh_region
}

*/