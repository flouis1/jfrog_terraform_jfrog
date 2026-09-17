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
# Coexists with project-scoped watches in teams/* :
#   - platform watch  = enterprise floor (all-repos)
#   - team watch      = project-owned (project_key), managed by Project Admins
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
    package_types          = ["generic"]
    repos                  = [artifactory_local_generic_repository.audit_reports.key]
    included_packages      = ["**"]
    included_projects      = []
    include_all_projects   = true
    created_before_in_days = 730
  }
}

################################################################################
# SAML settings — configure SAML authentication for Entraid
################################################################################

resource "platform_saml_settings" "entraid-saml-settings" {
  # required params
  certificate           = var.entraid_certificate
  login_url             = var.entraid_login_url
  logout_url            = var.entraid_logout_url
  name                  = "entraid"
  service_provider_name = var.jfrog_url # Assuming same value set as identifier in Azure
  enable                = true # Self-Hosted only

  # optional params
  email_attribute              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  group_attribute              = "http://schemas.microsoft.com/ws/2008/06/identity/claims/groups"
  name_id_attribute            = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
  auto_user_creation           = true
  allow_user_to_access_profile = true
  auto_redirect                = true
  sync_groups                  = true
  verify_audience_restriction  = true
  use_encrypted_assertion      = false
}

resource "artifactory_scoped_token" "scim_admin_token" {
  username   = "scim_admin"
  expires_in = 0 // in seconds. 0 = Never expires
  description = "SCIM admin token for use with Entra ID"
  scopes = ["system:identities:r,w,d"]
}
