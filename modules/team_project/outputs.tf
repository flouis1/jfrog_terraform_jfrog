output "project_key" {
  description = "The project key created"
  value       = project.this.key
}

output "repository_keys" {
  description = "All repository keys assigned to this project"
  value       = local.all_repo_keys
}

output "watch_name" {
  description = "Project-scoped Xray watch name"
  value       = xray_watch.project.name
}
