################################################################################
# SAML settings — configure SAML authentication for Entraid
################################################################################

resource "platform_saml_settings" "entraid_saml_settings" {
  # required params
  certificate           = trimspace(file(var.saml_certificate_path))
  login_url             = var.saml_login_url
  logout_url            = var.saml_logout_url
  name                  = var.saml_settings_name
  service_provider_name = var.saml_service_provider_entity_id
  enable                = true

  # optional params
  email_attribute              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  group_attribute              = "http://schemas.microsoft.com/ws/2008/06/identity/claims/groups"
  name_id_attribute            = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
  auto_user_creation           = true
  allow_user_to_access_profile = true
}

resource "artifactory_scoped_token" "scim_admin_token" {
  username   = "scim_admin"
  expires_in = 0 // in seconds. 0 = Never expires. This should be adjusted in accordance with your organization's security policy.
  description = "SCIM admin token for use with Entra ID"
  scopes = ["system:identities:r,w,d"]
}
