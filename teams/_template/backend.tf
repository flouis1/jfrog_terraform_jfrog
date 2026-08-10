## Each team has its own state — isolated blast radius, no cross-team locking.
## Replace TEAM_KEY with the actual team project key.

# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state"
#     key            = "jfrog-projects/TEAM_KEY/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
