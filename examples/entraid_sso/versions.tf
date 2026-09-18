terraform {
  required_version = ">= 1.5"

  required_providers {
    artifactory = {
      source  = "jfrog/artifactory"
      version = "~> 12.11"
    }
    platform = {
      source  = "jfrog/platform"
      version = "~> 2.2"
    }
  }
}
