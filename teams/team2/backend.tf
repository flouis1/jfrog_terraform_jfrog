## WARNING: local state by default.
## Before any real/shared usage, uncomment ONE backend below and set real values.
## Each team MUST use a unique state path.

## Recommended for JFrog platforms — store state in a Generic Artifactory repo
# terraform {
#   backend "artifactory" {
#     url     = "https://your-instance.jfrog.io/artifactory"
#     repo    = "terraform-state"
#     subpath = "jfrog-projects/team2"
#   }
# }

## Alternative: S3 (AWS / MinIO / compatible)
# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state"
#     key            = "jfrog-projects/team2/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

## Alternative: GCS
# terraform {
#   backend "gcs" {
#     bucket = "my-terraform-state"
#     prefix = "jfrog-projects/team2"
#   }
# }
