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
