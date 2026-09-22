################################################################################
# Create a service account for use with CI tools
################################################################################

resource "artifactory_user" "my_ci_user" {
  name = var.ci_user_name
  email = var.ci_user_email
  disable_ui_access = true
  groups = ["readers"]
}

resource "artifactory_scoped_token" "ci_user_token" {
  depends_on = [artifactory_user.my_ci_user]

  username = var.ci_user_name
  expires_in = 0 // in seconds. 0 = Never expires. This should be adjusted in accordance with your organization's security policy.
  description = "CI user token for use with CI tools"
  scopes = ["applied-permissions/user"]
}
