variable "jfrog_url" {
  description = "JFrog Platform URL (e.g. https://myinstance.jfrog.io)"
  type        = string
}

variable "ci_user_name" {
  description = "Name of the service account."
  type        = string
}

variable "ci_user_email" {
  description = "Email of the service account. This could be a team's distribution list."
  type        = string
}

variable "oidc_issuer_url" {
  description = "Issuer URL of the oidc identity provider. Override the default if using self-hosted GitLab."
  type        = string
  default     = "https://gitlab.com/"
}

variable "oidc_settings_name" {
  description = "Name for the oidc configuration. Unique ID in the JFrog Platform."
  type        = string
  default     = "gitlab-oidc-configuration"
}

variable "identity_mapping_name" {
  description = "Name for the identity mapping. Unique ID in the JFrog Platform."
  type        = string
}

variable "identity_mapping_priority" {
  description = "Priority for the identity mapping. Lower numbers are higher priority."
  type        = number
}

variable "claims_json_path" {
  description = "Path to the JSON file containing the claims for the oidc mapping."
  type        = string
}

variable "expiry_seconds" {
  description = "Expiry time in seconds for the oidc mapping."
  type        = number
  default     = 7200
}
