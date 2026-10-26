resource "artifactory_user" "my_oidc_user" {
  name = var.ci_user_name
  email = var.ci_user_email
  disable_ui_access = true
  groups = ["readers"]
}

resource "platform_oidc_configuration" "gitlab-oidc-configuration" {
  name          = var.oidc_settings_name
  issuer_url    = var.oidc_issuer_url
  provider_type = "generic"
}

resource "platform_oidc_identity_mapping" "gitlab-oidc-identity-mapping" {
  depends_on = [platform_oidc_configuration.gitlab-oidc-configuration, artifactory_user.my_oidc_user]

  name          = var.identity_mapping_name
  provider_name = var.oidc_settings_name
  priority      = var.identity_mapping_priority

  claims_json = trimspace(file(var.claims_json_path))

  token_spec = {
    username       = var.ci_user_name
    scope          = "applied-permissions/user"
    audience       = "*@*"
    expires_in     = var.expiry_seconds
  }
}
