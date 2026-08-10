################################################################################
# Project-scoped Xray watch
#
# Lives inside the JFrog Project (project_key) so Project Admins can manage it
# without touching the global watch. Attaches the enterprise baseline policy
# (created by platform/) plus any optional team-specific policies.
################################################################################

resource "xray_watch" "project" {
  name        = "watch-${var.project_key}"
  description = "Project watch for ${var.project_display_name} — baseline + team policies"
  active      = true
  project_key = project.this.key

  watch_resource {
    type = "project"
    name = project.this.key
  }

  assigned_policy {
    name = var.global_security_policy_name
    type = "security"
  }

  dynamic "assigned_policy" {
    for_each = var.team_security_policy_names
    content {
      name = assigned_policy.value
      type = "security"
    }
  }

  depends_on = [project_repository.repos]
}
