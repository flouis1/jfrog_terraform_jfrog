variable "project_key" {
  description = "Unique short key for the project (max 32 chars, lowercase, no spaces)"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,31}$", var.project_key))
    error_message = "project_key must be lowercase alphanumeric + hyphens, 2-32 chars, starting with a letter."
  }
}

variable "project_display_name" {
  description = "Human-readable display name for the project"
  type        = string
}

variable "project_description" {
  description = "Description of the team project"
  type        = string
  default     = ""
}

variable "max_storage_in_gibibytes" {
  description = "Max storage quota for this project (GiB). -1 = unlimited."
  type        = number
  default     = -1
}

variable "team_admin_groups" {
  description = "List of groups to assign as Project Admins"
  type        = list(string)
  default     = []
}

variable "team_member_groups" {
  description = "List of groups to assign as Project Members (deploy + read)"
  type        = list(string)
  default     = []
}

variable "repositories" {
  description = "Repositories to create and assign to the project. Supported package_type: docker, generic only."
  type = list(object({
    key          = string
    type         = string # local, remote, virtual
    package_type = string # docker | generic
    description  = string
    environments = optional(list(string), ["DEV"])
    url          = optional(string, "") # required for remote repos
    xray_index   = optional(bool, true)
    members      = optional(list(string), []) # virtual repo: list of repo keys to aggregate
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.repositories : contains(["docker", "generic"], r.package_type)
    ])
    error_message = "repositories[*].package_type must be one of: docker, generic."
  }

  validation {
    condition = alltrue([
      for r in var.repositories : contains(["local", "remote", "virtual"], r.type)
    ])
    error_message = "repositories[*].type must be one of: local, remote, virtual."
  }
}

variable "global_security_policy_name" {
  description = "Platform baseline Xray security policy name. Set to empty string to skip (use when platform all-repos watch already covers baseline and you want to avoid duplicate violations)."
  type        = string
  default     = "policy-security-baseline"
}

variable "team_security_policy_names" {
  description = "Optional extra Xray security policies owned by this team (must already exist)"
  type        = list(string)
  default     = []
}
