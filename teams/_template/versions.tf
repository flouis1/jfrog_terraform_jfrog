terraform {
  required_version = ">= 1.5"

  required_providers {
    artifactory = {
      source  = "jfrog/artifactory"
      version = "~> 12.11"
    }
    project = {
      source  = "jfrog/project"
      version = "~> 1.9"
    }
    xray = {
      source  = "jfrog/xray"
      version = "~> 3.1"
    }
  }
}
