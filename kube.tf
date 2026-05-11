
# Create an OVHcloud Managed Kubernetes cluster
resource "ovh_cloud_project_kube" "kube_cluster" {
  service_name = var.ovh_tenantid
  name         = var.ManagedKMSCliuster.name
  region       = var.ovh_region
  version      = var.ManagedKMSCliuster.version
}

# Create a Node Pool for our Kubernetes clusterx
resource "ovh_cloud_project_kube_nodepool" "node_pool" {
  service_name  = var.ovh_tenantid
  kube_id       = ovh_cloud_project_kube.kube_cluster.id
  name          = var.ManagedKMSCliuster.name
  flavor_name   = var.ManagedKMSCliuster.size
  desired_nodes = var.ManagedKMSCliuster.nodes_count
  min_nodes     = var.ManagedKMSCliuster.nodes_min
  max_nodes     = var.ManagedKMSCliuster.nodes_max
}