
## https://registry.terraform.io/providers/ovh/ovh/latest/docs/resources/me_identity_group

# Create Users
resource "ovh_me_identity_group" "groups" {
  for_each = toset(var.iam_groups)  # konverterer listen til set for unique keys
  name        = each.value
  description = "IAM group ${each.value}"
}

resource "ovh_me_identity_user" "users" {
  for_each = { for u in var.users.accounts : u.login => u }
  email       = each.value.email
  description = each.value.description
  password    = var.users.default_password
  login       = each.value.login
  group       = lookup(each.value, "group", null) 
}


/*

# create a group allowing all actions in the category READ on VPSs
resource "ovh_iam_permissions_group" "read_vps" {
  name        = "read_vps"
  description = "Read access to vps"

  allow = [
    for act in data.ovh_iam_reference_actions.vps.actions : act.action if(contains(act.categories, "READ"))
  ]
}
*/
