terraform {
  required_providers {
    artifactory = {
      source = "jfrog/artifactory"
      version = "12.5.1"
    }
    project = {
      source = "jfrog/project"
      version = "1.9.1"
    }
  }
}