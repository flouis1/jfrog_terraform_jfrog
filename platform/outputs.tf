output "baseline_policy_name" {
  description = "Global security policy name — teams can attach this to project watches"
  value       = xray_security_policy.baseline.name
}

output "baseline_watch_name" {
  description = "Global watch covering all repositories"
  value       = xray_watch.baseline.name
}

output "audit_reports_repo" {
  description = "Generic repo for archived Xray report CSVs"
  value       = artifactory_local_generic_repository.audit_reports.key
}
