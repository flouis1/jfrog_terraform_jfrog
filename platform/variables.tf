variable "jfrog_url" {
  description = "JFrog Platform URL (e.g. https://myinstance.jfrog.io)"
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
