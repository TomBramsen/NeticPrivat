
/*
resource "openstack_networking_network_v2" "private_net" {
  name           = "terraform-private-network"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name       = "terraform-private-subnet"
  network_id = openstack_networking_network_v2.private_net.id
  cidr       = "192.168.10.0/24"
  ip_version = 4
}

*/
//////

// OVH Abstraction on top of openstack

// In OVH Cloud, a vnet is vlan representation, and subnet is CIDR, so you do not have several subnets under a vnet
// Hence - more subnets : create more vnets
resource "ovh_cloud_project_network_private" "net" {
  service_name = var.ovh_project_id
  name         = var.network.name
  vlan_id      = var.network.vlan

  regions = [
    for r in var.network.regions : r.region
  ]
}

resource "ovh_cloud_project_network_private_subnet" "subnet" {
  for_each = {
    for r in var.network.regions :
    r.region => r
  }

  service_name = var.ovh_project_id
  network_id   = ovh_cloud_project_network_private.net.id

  region  = each.value.region
  network = each.value.subnet

  start = cidrhost(
    each.value.subnet,
    each.value.IPallocationStart
  )

  end = cidrhost(
    each.value.subnet,
    each.value.IPallocationStop
  )

  dhcp       = true
  no_gateway = false
}
