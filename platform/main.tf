################################################################################
# Global security baseline — NOT tied to any JFrog Project
#
# Owned by the Platform / Enterprise Architecture team.
# Team stacks (teams/*) attach this policy to their project-scoped watches,
# or add team-specific policies on top. They must not recreate this baseline.
################################################################################

resource "xray_security_policy" "baseline" {
  name        = "policy-security-baseline"
  description = "Global baseline: block malicious packages, alert on High/Critical CVEs"
  type        = "security"

  rule {
    name     = "block-malicious-packages"
    priority = 1

    criteria {
      malicious_package = true
    }

    actions {
      block_download {
        active    = true
        unscanned = false
      }
      fail_build              = true
      notify_deployer         = true
      notify_watch_recipients = true
    }
  }

  rule {
    name     = "alert-high-critical-cve"
    priority = 2

    criteria {
      min_severity = "High"
    }

    actions {
      block_download {
        active    = false
        unscanned = false
      }
      fail_build              = false
      notify_deployer         = true
      notify_watch_recipients = true
    }
  }
}

################################################################################
# Global watch — applies the baseline policy across all repositories
#
# Teams may add project-scoped watches for extra rules. This watch is the
# enterprise floor that every artifact must pass.
################################################################################

resource "xray_watch" "baseline" {
  name        = "watch-security-baseline"
  description = "Global watch — baseline security policy on all repositories"
  active      = true

  watch_resource {
    type = "all-repos"
  }

  assigned_policy {
    name = xray_security_policy.baseline.name
    type = "security"
  }
}

################################################################################
# Audit archive — stores exported Xray report CSVs (not scannable artifacts)
# Intentionally NOT indexed by Xray.
################################################################################

resource "artifactory_local_generic_repository" "audit_reports" {
  key         = "audit-reports-local"
  description = "Archive for Xray security report exports (CSV). Not indexed by Xray."
}

################################################################################
# Cleanup — 730-day retention on archived reports
# enabled = false on first create (Artifactory API requirement); flip to true
# after the first successful apply.
################################################################################

resource "artifactory_package_cleanup_policy" "audit_reports_retention" {
  key             = "audit-reports-cleanup-730d"
  description     = "Purge archived Xray CSV reports older than 730 days"
  cron_expression = "0 0 3 ? * SUN *"
  enabled         = false
  skip_trashcan   = false

  search_criteria = {
    package_types        = ["generic"]
    repos                = [artifactory_local_generic_repository.audit_reports.key]
    included_packages    = ["**"]
    included_projects    = []
    include_all_projects = true
    created_before_in_days = 730
  }
}
