resource "project" "sample" {
  display_name = "sample project"
  key          = "sample"
  description = "Sample project deployed with Terraform"

  admin_privileges {
    index_resources  = true
    manage_members   = true
    manage_resources = true
  }

  max_storage_in_gibibytes = 10
  block_deployments_on_limit = false
  email_notification = false
}