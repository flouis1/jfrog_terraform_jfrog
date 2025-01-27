module "shared_configuration" {
  source = "../modules/shared_config"
  jfrog_url = var.jfrog_url
}