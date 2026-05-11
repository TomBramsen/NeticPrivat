
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

