## WARNING: local state by default.
## Before any shared / CI usage, uncomment ONE backend below and set real values.
##
## Do NOT store this state inside the JFrog Platform this code manages.
## This stack configures Artifactory repositories, Projects and Xray policies —
## keeping its state on that same platform creates a circular dependency:
## a bad apply or a platform outage would lock you out of your own state.
##
## Note: the legacy `backend "artifactory"` block was removed in Terraform 1.3
## and cannot be used here (required_version >= 1.5).

## S3 (AWS / MinIO / compatible) — locking via DynamoDB
# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state"
#     key            = "jfrog-projects/team2/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

## GCS — locking built in
# terraform {
#   backend "gcs" {
#     bucket = "my-terraform-state"
#     prefix = "jfrog-projects/team2"
#   }
# }

## Azure Blob Storage — locking via blob lease
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "tfstate-rg"
#     storage_account_name = "mytfstate"
#     container_name       = "tfstate"
#     key                  = "jfrog-projects/team2/terraform.tfstate"
#   }
# }
