
// Object storage (S3 compatible)
// For Velero etc

resource "ovh_cloud_project_storage" "storage" {
  service_name = var.ovh_project_id
  region_name  = var.storage.region
  name         = var.storage.name
  versioning = {
    status = var.storage.versioning
  }
  /*
    object_lock = {
    status = "enabled"
    rule = {
      mode   = "governance"
      period = "P30D" # 30 days retention
    }

  encryption = {
    sse_algorithm = "AES256"
  }
  */
}


// Block storage
// For use for Persistant Volumes in K8S
resource "openstack_blockstorage_volume_v3" "data" {
  name = "prod-data-volume"

  size = 10

  volume_type = "classic" // "high-speed"
}


// Usecase : 

/*
terraform {
  backend "s3" {
    bucket = "tf-state-prod"
    key    = "network/terraform.tfstate"
    region = "GRA"

    endpoints = {
      s3 = "https://s3.gra.io.cloud.ovh.net"
    }

    skip_credentials_validation = true
    skip_region_validation      = true
  }
}
*/
