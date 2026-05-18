
#  Azure Key Vault is in OVHcloud two services:
#
# OVHcloud KMS (Key Management Service): encryption keys
# OVHcloud Secret Manager: Passwords, API-keys and certificates

# KMS
resource "ovh_okms" "kms" {
  count          = var.keyvault.deploy ? 1 : 0
  display_name   = var.keyvault.name
  region         = var.keyvault.region
  ovh_subsidiary = var.keyvault.subsidary # var.ovh_api_region'
}

resource "ovh_okms_secret" "example" {
  count = var.keyvault.deploy ? 1 : 0
  okms_id = ovh_okms.kms[0].id
  path    = "app/api_credentials_example"

  metadata = {
    max_versions             = 10   # keep last 10 versions
    cas_required             = true # enforce optimistic concurrency control (server will require current secret version on the cas attribute to allow update)
    deactivate_version_after = "0s" # keep versions active indefinitely (example)
    custom_metadata = {
      environment = "prod"
      owner       = "payments-team"
    }
  }

  # Initial version (will create version 1)
  version = {
    data = jsonencode({
      api_key    = "var.api_key"
      api_secret = base64encode("my-secret-password")
    })
  }
}

resource "ovh_okms_secret" "code2" {
  count = var.keyvault.deploy ? 1 : 0
  okms_id = ovh_okms.kms[0].id
  path    = "app/api_credentials"
  version = {
    data = jsonencode({
      api_key    = "key"
      api_secret = "new secret"
    })
  }
}
# terraform import -var-file="variables.tfvars" ovh_okms.my_kms 82212d39-33d8-47d7-a4d3-eebc96579b54
# terraform state rm ovh_okms.my_kms2
