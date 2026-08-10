locals {
  teams = yamldecode(file("${path.module}/teams.yaml"))
}

module "team_project" {
  source   = "./modules/team_project"
  for_each = { for t in local.teams : t.project_key => t }

  project_key          = each.value.project_key
  project_display_name = each.value.display_name
  project_description  = lookup(each.value, "description", "")

  team_admin_groups  = lookup(each.value, "admin_groups", [])
  team_member_groups = lookup(each.value, "member_groups", [])

  repositories = lookup(each.value, "repositories", [])
}
