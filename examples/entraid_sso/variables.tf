variable "saml_certificate_path" {
  description = "Path to the SAML identity provider X.509 certificate. This can be downloaded from Azure."
  type        = string
}

variable "saml_login_url" {
  description = "SAML identity provider login URL. This should be retrieved from Azure."
  type        = string
}

variable "saml_logout_url" {
  description = "SAML identity provider logout URL. This should be retrieved from Azure."
  type        = string
}

variable "saml_settings_name" {
  description = "Name for the SAML configuration. This should be a unique ID in the JFrog Platform, forming part of the reply URL to be configured in Azure."
  type        = string
}

variable "saml_service_provider_entity_id" {
  description = "Entity ID or Identifier. This can be the JFrog URL, but the same value should be configured in Azure."
  type        = string
}
