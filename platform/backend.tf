## WARNING: local state by default.
## Before any shared / CI usage, uncomment ONE backend below and set real values.
##
## Do NOT store this state inside the JFrog Platform this code manages.
## Note: the legacy `backend "artifactory"` block was removed in Terraform 1.3.

## S3 (AWS / MinIO / compatible)
# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state"
#     key            = "jfrog-platform/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

## GCS
# terraform {
#   backend "gcs" {
#     bucket = "my-terraform-state"
#     prefix = "jfrog-platform"
#   }
# }

## Azure Blob Storage
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "tfstate-rg"
#     storage_account_name = "mytfstate"
#     container_name       = "tfstate"
#     key                  = "jfrog-platform/terraform.tfstate"
#   }
# }
