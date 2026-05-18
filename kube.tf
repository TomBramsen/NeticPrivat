
# Create an OVHcloud Managed Kubernetes cluster
resource "ovh_cloud_project_kube" "kube_cluster" {
  count       = var.ManagedKMSCliuster.deploy ? 1 : 0
  service_name = var.ovh_project_id
  name         = var.ManagedKMSCliuster.name
  region       = var.ovh_region
  version      = var.ManagedKMSCliuster.version
}

# Create a Node Pool for our Kubernetes clusterx
resource "ovh_cloud_project_kube_nodepool" "node_pool" {
  count         = var.ManagedKMSCliuster.deploy ? 1 : 0
  service_name  = var.ovh_project_id
  kube_id       = ovh_cloud_project_kube.kube_cluster[0].id
  name          = var.ManagedKMSCliuster.name
  flavor_name   = var.ManagedKMSCliuster.size
  desired_nodes = var.ManagedKMSCliuster.nodes_count
  min_nodes     = var.ManagedKMSCliuster.nodes_min
  max_nodes     = var.ManagedKMSCliuster.nodes_max

  template {
    metadata {
      annotations = {
        k1 = "v1"
        k2 = "v2"
      }
      finalizers = []
      labels = {
        k3 = "v3"
        k4 = "v4"
      }
    }
    spec {
      unschedulable = false
      taints = [
        {
          effect = "PreferNoSchedule"
          key    = "k"
          value  = "v"
        }
      ]
    }
  }
}

/*
// Kube-API IP Access restrictions
resource "ovh_cloud_project_kube_iprestrictions" "vrack_only" {
  service_name = var.ovh_project_id
  kube_id      = ovh_cloud_project_kube.kube_cluster.id
  ips          = ["185.29.0.0/26"]
}
*/
