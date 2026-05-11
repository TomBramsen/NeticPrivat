variable "OS_user" {}
variable "OS_password" {}

variable "ovh_region" {}
variable "ovh_project_name" {}
variable "ovh_application_key" {}
variable "ovh_application_secret" {}
variable "ovh_consumer_key" {}
variable "ovh_tenantid" {}
variable "ovh_api_region" {}

variable "ControlPlaneVM" {
  type = object({
    name_prefix = string
    size        = string
    image_name  = string
    count       = number
  })
  default = {
    name_prefix = "vm-worker"
    size        = "d2-2"
    image_name  = "Ubuntu 24.04"
    count       = 0
  }
}

variable "ManagedKMSCliuster" {
  type = object({
    name        = string
    size        = string
    image_name  = string
    version     = string
    nodes_count = number
    nodes_min   = number
    nodes_max   = number
  })
  default = {
    name        = "kms-cluster" //Warning: "_" char is not allowed!
    size        = "b2-7"
    image_name  = "Ubuntu 24.04"
    version     = "1.34"
    nodes_count = 1
    nodes_min   = 1
    nodes_max   = 3
  }
}
