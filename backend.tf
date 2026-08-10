## Remote backend — REQUIRED for team/CI usage.
## Uncomment ONE of the options below and configure it.

## Option 1: S3-compatible (AWS, MinIO, etc.)
# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state"
#     key            = "jfrog-projects/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

## Option 2: Artifactory (state stored in a Generic repo)
# terraform {
#   backend "artifactory" {
#     url     = "https://your-instance.jfrog.io/artifactory"
#     repo    = "terraform-state"
#     subpath = "jfrog-projects"
#   }
# }

## Option 3: GCS
# terraform {
#   backend "gcs" {
#     bucket = "my-terraform-state"
#     prefix = "jfrog-projects"
#   }
# }
