output "scim_admin_token" {
  description = "SCIM admin token to be consumed by Entra ID"
  value       = artifactory_scoped_token.scim_admin_token.access_token
  sensitive   = true
  # This will be stored in tf state. Copy this into Azure and restrict access to it.
}
