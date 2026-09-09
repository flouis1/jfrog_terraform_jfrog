variable "jfrog_url" {
  description = "JFrog Platform URL (e.g. https://myinstance.jfrog.io)"
  type        = string
}

variable "entraid_certificate" {
  description = "SAML identity provider X.509 certificate."
  type        = string
}

variable "entraid_login_url" {
  description = "SAML identity provider login URL."
  type        = string
}

variable "entraid_logout_url" {
  description = "SAML identity provider logout URL."
  type        = string
}

variable "JFROG_ACCESS_TOKEN" {
  description = "JFrog access token with admistrative permissions."
  type        = string
}

variable "ci_user_name" {
  description = "Name for the service account."
  type        = string
}

variable "ci_user_email" {
  description = "Email for the service account. For example, the platform team's distribution list."
  type        = string
}
