

# Generate SSH keypair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key locally
resource "local_file" "private_key" {
  filename        = "${path.module}/id_rsa"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}

# Upload public key til OVH/OpenStack
resource "openstack_compute_keypair_v2" "default" {
  name       = "terraform-generated-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}


## Generate VM

# VM
resource "openstack_compute_instance_v2" "ControlPlaneVM" {
  count           = var.ControlPlaneVM.count
  name            = "${var.ControlPlaneVM.name_prefix}-${count.index}"
  flavor_name     = var.ControlPlaneVM.size
  image_name      = var.ControlPlaneVM.image_name
  key_pair        = openstack_compute_keypair_v2.default.name
  security_groups = ["default"]
  network {
    uuid =  openstack_networking_network_v2.private_net.id
  }
}

# show private key as output
output "private_ssh_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

# SSH kommando
/*
output "ssh_command" {
  value = "ssh ubuntu@${openstack_compute_instance_v2.cheap_vm.access_ip_v4} -i id_rsa"
}
*/
output "vm_info" {

  value = [
    for vm in openstack_compute_instance_v2.ControlPlaneVM : {
      ip   = try(vm.access_ip_v4, null)
      ssh  = try("ssh ubuntu@${vm.access_ip_v4} -i id_rsa", null)
      name = vm.name

    }
  ]
}
