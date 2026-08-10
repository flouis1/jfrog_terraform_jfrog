output "project_key" {
  description = "The project key created"
  value       = project.this.key
}

output "repository_keys" {
  description = "All repository keys assigned to this project"
  value       = local.all_repo_keys
}
