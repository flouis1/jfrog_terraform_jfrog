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

provider "project" {
  url = var.jfrog_url
}

provider "artifactory" {
  url = "${var.jfrog_url}/artifactory"
}