provider "artifactory" {
  url = "${var.jfrog_url}/artifactory"
}

provider "project" {
  url = var.jfrog_url
}
