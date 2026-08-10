output "project_key" {
  description = "JFrog Project key for this team"
  value       = module.team_project.project_key
}

output "repository_keys" {
  description = "Repository keys created and assigned to this project"
  value       = module.team_project.repository_keys
}

output "watch_name" {
  description = "Project-scoped Xray watch name"
  value       = module.team_project.watch_name
}
