locals {
  dev_environment = "DEV"
  stg_environment = "STAGING"
  prd_environment = "PROD"
}

## Sample project

resource "artifactory_local_docker_v2_repository" "sample_docker_dev" {
  key = "sample-docker-dev-local"
  project_environments = [local.dev_environment]
  xray_index = true

  lifecycle {
    ignore_changes = [
      project_key
    ]
  }
}

resource "project_repository" "sample_docker_dev" {
  project_key = project.sample.key
  key         = artifactory_local_docker_v2_repository.sample_docker_dev.key
}

resource "artifactory_local_docker_v2_repository" "sample_docker_stg" {
  key = "sample-docker-stg-local"
  project_environments = [local.stg_environment]
  xray_index = true

  lifecycle {
    ignore_changes = [
      project_key
    ]
  }
}

resource "project_repository" "sample_docker_stg" {
  project_key = project.sample.key
  key         = artifactory_local_docker_v2_repository.sample_docker_stg.key
}

resource "artifactory_local_docker_v2_repository" "sample_docker_prd" {
  key = "sample-docker-prd-local"
  project_environments = [local.prd_environment]
  xray_index = true

  lifecycle {
    ignore_changes = [
      project_key
    ]
  }
}

resource "project_repository" "sample_docker_prd" {
  project_key = project.sample.key
  key         = artifactory_local_docker_v2_repository.sample_docker_prd.key
}

resource "artifactory_remote_docker_repository" "sample_docker_remote" {
  key = "sample-docker-remote"
  project_environments = [local.prd_environment]
  url = "https://registry-1.docker.io/"
  xray_index = true

  block_pushing_schema1 = true
  enable_token_authentication = true

  lifecycle {
    ignore_changes = [
      project_key
    ]
  }
}

resource "project_repository" "sample_docker_remote" {
  project_key = project.sample.key
  key         = artifactory_remote_docker_repository.sample_docker_remote.key
}

resource "artifactory_virtual_docker_repository" "sample_docker_virtual" {
  key = "sample-docker-virtual"
  description = "Unique endpoint for all docker local repositories of this project"
  repositories = [
    artifactory_local_docker_v2_repository.sample_docker_dev.key,
    artifactory_local_docker_v2_repository.sample_docker_stg.key,
    artifactory_local_docker_v2_repository.sample_docker_prd.key,
    artifactory_remote_docker_repository.sample_docker_remote.key
  ]
  default_deployment_repo = artifactory_local_docker_v2_repository.sample_docker_dev.key

  lifecycle {
    ignore_changes = [
      project_key
    ]
  }
}

resource "project_repository" "sample_docker_virtual" {
  project_key = project.sample.key
  key         = artifactory_virtual_docker_repository.sample_docker_virtual.key
}