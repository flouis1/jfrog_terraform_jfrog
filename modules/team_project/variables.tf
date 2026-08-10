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
  description = "Repositories to create and assign to the project"
  type = list(object({
    key          = string
    type         = string # local, remote, virtual
    package_type = string # docker, maven, nuget, npm, generic, etc.
    description  = string
    environments = optional(list(string), ["DEV"])
    url          = optional(string, "")       # required for remote repos
    xray_index   = optional(bool, true)
    members      = optional(list(string), []) # virtual repo: list of repo keys to aggregate
  }))
  default = []
}
