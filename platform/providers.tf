provider "artifactory" {
  url = "${trimsuffix(var.jfrog_url, "/")}/artifactory"
}

provider "platform" {
  url = "${trimsuffix(var.jfrog_url, "/")}/platform"
}

provider "xray" {
  url = "${trimsuffix(var.jfrog_url, "/")}/xray"
}
