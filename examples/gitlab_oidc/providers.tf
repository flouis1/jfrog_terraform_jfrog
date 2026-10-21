provider "artifactory" {
  url = "${trimsuffix(var.jfrog_url, "/")}/artifactory"
}

provider "platform" {
  url = "${trimsuffix(var.jfrog_url, "/")}/platform"
}
