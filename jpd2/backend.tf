# Local backend is not recommended for production environment

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}