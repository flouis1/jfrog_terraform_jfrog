resource "project_group" "admins" {
  for_each    = toset(var.team_admin_groups)
  project_key = project.this.key
  name        = each.value
  roles       = ["Project Admin"]
}

resource "project_group" "members" {
  for_each    = toset(var.team_member_groups)
  project_key = project.this.key
  name        = each.value
  roles       = ["Developer"]
}
