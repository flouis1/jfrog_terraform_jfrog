output "ci_user_token" {
  description = "User authentication token to be configured in the CI/CD platform"
  value       = artifactory_scoped_token.ci_user_token.access_token
  sensitive   = true
  # This will be stored in tf state. Copy this into Azure and restrict access to it.
}
