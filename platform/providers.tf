provider "artifactory" {
  url = "${var.jfrog_url}/artifactory"
}

provider "platform" {
  url = "${var.jfrog_url}/platform"
}

provider "xray" {
  url = "${var.jfrog_url}/xray"
}
