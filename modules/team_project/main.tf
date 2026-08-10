resource "project" "this" {
  key          = var.project_key
  display_name = var.project_display_name
  description  = var.project_description

  admin_privileges {
    index_resources  = true
    manage_members   = true
    manage_resources = true
  }

  max_storage_in_gibibytes   = var.max_storage_in_gibibytes
  block_deployments_on_limit = false
  email_notification         = true
}

locals {
  local_repos   = [for r in var.repositories : r if r.type == "local"]
  remote_repos  = [for r in var.repositories : r if r.type == "remote"]
  virtual_repos = [for r in var.repositories : r if r.type == "virtual"]
}

resource "artifactory_local_docker_v2_repository" "docker" {
  for_each             = { for r in local.local_repos : r.key => r if r.package_type == "docker" }
  key                  = each.value.key
  description          = each.value.description
  project_environments = each.value.environments
  xray_index           = each.value.xray_index

  lifecycle {
    ignore_changes = [project_key]
  }
}

resource "artifactory_local_generic_repository" "generic" {
  for_each    = { for r in local.local_repos : r.key => r if r.package_type == "generic" }
  key         = each.value.key
  description = each.value.description

  lifecycle {
    ignore_changes = [project_key]
  }
}

resource "artifactory_remote_docker_repository" "docker" {
  for_each                    = { for r in local.remote_repos : r.key => r if r.package_type == "docker" }
  key                         = each.value.key
  description                 = each.value.description
  url                         = each.value.url
  project_environments        = each.value.environments
  xray_index                  = each.value.xray_index
  block_pushing_schema1       = true
  enable_token_authentication = true

  lifecycle {
    ignore_changes = [project_key]
  }
}

resource "artifactory_virtual_docker_repository" "docker" {
  for_each                = { for r in local.virtual_repos : r.key => r if r.package_type == "docker" }
  key                     = each.value.key
  description             = each.value.description
  repositories            = each.value.members
  default_deployment_repo = length(each.value.members) > 0 ? each.value.members[0] : null

  depends_on = [
    artifactory_local_docker_v2_repository.docker,
    artifactory_remote_docker_repository.docker,
  ]

  lifecycle {
    ignore_changes = [project_key, repositories]
  }
}

locals {
  all_repo_keys = concat(
    [for k, v in artifactory_local_docker_v2_repository.docker : v.key],
    [for k, v in artifactory_local_generic_repository.generic : v.key],
    [for k, v in artifactory_remote_docker_repository.docker : v.key],
    [for k, v in artifactory_virtual_docker_repository.docker : v.key],
  )
}

resource "project_repository" "repos" {
  for_each    = toset(local.all_repo_keys)
  project_key = project.this.key
  key         = each.value
}
