

######################################
###         Generate VMs           ###
######################################
/*

resource "openstack_compute_instance_v2" "VMs" {
  count           = var.ControlPlaneVM.count
  name            = "${var.ControlPlaneVM.name_prefix}-${count.index}"
  flavor_name     = var.ControlPlaneVM.size
  image_name      = var.ControlPlaneVM.image_name
  key_pair        = openstack_compute_keypair_v2.default.name
  security_groups = ["default"]
  network {
    name = ovh_cloud_project_network_private.net.name
  }
  lifecycle {
    # OVHcloud regularly updates the base image of a given OS so that customer has less packages to update after spawning a new instance
    # To avoid terraform to have some issue with that, the following ignore_changes is required.
    ignore_changes = [
      image_name
    ]
  }
}


// deploy 1 if above count is greater than 0

resource "openstack_compute_instance_v2" "VMPublicNet" {
  count           = var.ControlPlaneVM.count > 0 ? 1 : 0
  name            = "publicnet-${count.index}"
  flavor_name     = var.ControlPlaneVM.size
  image_name      = "Windows Server 2025 Standard (Desktop)"
  admin_pass      = "Kodeord1"
  security_groups = ["default"]
  network {
    name = ovh_cloud_project_network_private.net.name
  }
  network {
    name = "Ext-Net"
  }
  lifecycle {
    # OVHcloud regularly updates the base image of a given OS so that customer has less packages to update after spawning a new instance
    # To avoid terraform to have some issue with that, the following ignore_changes is required.
    ignore_changes = [
      image_name
    ]
  }
}



### Outputs

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

/*
output "vm_info" {

  value = [
    for vm in openstack_compute_instance_v2.VMs : {
      ip   = try(vm.access_ip_v4, null)
      ssh  = try("ssh ubuntu@${vm.access_ip_v4} -i id_rsa", null)
      name = vm.name

    }
  ]
}
*/


