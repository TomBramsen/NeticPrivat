# Managed Private Registry.   OVH Clouds version of Azure Container Registry (ACR)
# https://help.ovhcloud.com/csm/en-public-cloud-private-registry-kubernetes?id=kb_article_view&sysparm_article=KB0050381

/*
data "ovh_cloud_project_capabilities_containerregistry_filter" "capabilities" {
  service_name = var.ovh_tenantid
  plan_name    = ovh_cloud_project_kube.kube_cluster.plan
  region       = var.ovh_region
  depends_on = [ ovh_cloud_project_kube_nodepool.node_pool ]
}
*/

resource "ovh_cloud_project_containerregistry" "registry" {
 count         = var.ContainerRegistry.deploy ? 1 : 0
  service_name = var.ovh_tenantid
  region       = var.ContainerRegistry.region
  name         = var.ContainerRegistry.name
}

resource "ovh_cloud_project_containerregistry_user" "user" {
    count         = var.ContainerRegistry.deploy ? 1 : 0
    service_name = ovh_cloud_project_containerregistry.registry[0].service_name
    registry_id  = ovh_cloud_project_containerregistry.registry[0].id
    email        = "my.user@mycompany.com"
    login        = "myuser"
}

output "registry-url" {
     value = var.ContainerRegistry.deploy  ? ovh_cloud_project_containerregistry.registry[0].url : null 
}

output "user" {
  value = var.ContainerRegistry.deploy  ?  ovh_cloud_project_containerregistry_user.user[0].user    : null 
}

output "password" {
  value = var.ContainerRegistry.deploy  ? ovh_cloud_project_containerregistry_user.user[0].password    : null 
  sensitive = true
}

// Get with "terraform output password"