output "projects" {
  description = "Map of project keys to their repository keys"
  value = {
    for k, v in module.team_project : k => {
      project_key     = v.project_key
      repository_keys = v.repository_keys
    }
  }
}
