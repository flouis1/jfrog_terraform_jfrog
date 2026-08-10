provider "artifactory" {
  url = "${var.jfrog_url}/artifactory"
}

provider "xray" {
  url = "${var.jfrog_url}/xray"
}
