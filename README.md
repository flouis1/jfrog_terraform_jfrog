# Terraform — JFrog Project per Team

Demonstrates the **one project per team** pattern on JFrog Platform using Terraform, with a separate **platform** stack for global config that is not tied to any project.

## Repository structure

```
.
├── platform/                   # Global baseline (own state) — apply FIRST
│   ├── main.tf                 # Global Xray policy + watch, audit archive
│   └── ...
├── modules/
│   └── team_project/           # Reusable module: project + repos + group assignments
└── teams/
    ├── _template/              # Copy this folder to onboard a new team
    ├── team1/                  # Team 1 — own state, own apply
    └── team2/                  # Team 2 — own state, own apply
```

## Two layers

| Layer | Path | Owns | Does NOT own |
|-------|------|------|--------------|
| **Platform** | `platform/` | Global Xray baseline policy + **all-repos watch**, audit-reports archive + cleanup | Team repos, project membership, project-scoped watches |
| **Team** | `teams/<team>/` | JFrog Project, team repos, group roles, **project-scoped watch** | Global security baseline policy |

Apply order:

```
1. platform/     →  global security floor + audit archive
2. teams/team1/  →  independent
3. teams/team2/  →  independent
```

Teams can attach the global policy (`policy-security-baseline`) to their own watches, or rely on the platform all-repos watch. They must not recreate the baseline policy.

### Watches: global + per project

Both layers create watches on purpose:

| Watch | Where | Scope | Who manages it |
|-------|-------|-------|----------------|
| `watch-security-baseline` | `platform/` | `all-repos` | Platform team |
| `watch-<project_key>` | `teams/<team>/` | that JFrog Project (`project_key` + `watch_resource type=project`) | Project Admins (team) |

The project watch can optionally attach **team-only** policies via `team_security_policy_names`.

By default the project watch also attaches the platform baseline policy by name. If the platform `all-repos` watch already covers that baseline, attaching it again on every project watch can duplicate violations/alerts. Prefer one of:

- **Platform covers baseline** — set project watches to team-only policies (`global_security_policy_name` unused / empty list of extras only), or
- **Keep both** — accept duplicate baseline signals for defense in depth during a demo

### Supported repository types

The `team_project` module currently creates **docker** and **generic** repos only (`local` / `remote` / `virtual` where applicable). Maven, NuGet, npm, etc. are not implemented yet — the variable validates `package_type` and will fail plan if you pass an unsupported type.

## Quick start — platform (global)

```bash
cd platform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars — set your JFrog Platform URL

export JFROG_ACCESS_TOKEN="<your-admin-token>"
terraform init
terraform plan
terraform apply
```

Creates:
- `policy-security-baseline` — block malicious, alert High/Critical
- `watch-security-baseline` — applies that policy to **all repositories**
- `audit-reports-local` — Generic archive for CSV exports (not Xray-indexed)
- `audit-reports-cleanup-730d` — cleanup policy (**created with `enabled = false`**; after first apply, set `enabled = true` in `platform/main.tf` and re-apply)

## Quick start — team

```bash
cd teams/team1
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars — set your JFrog Platform URL

export JFROG_ACCESS_TOKEN="<your-admin-token>"
terraform init
terraform plan
terraform apply
```

## Adding a new team

```bash
cp -r teams/_template teams/my-new-team
```

Then edit `teams/my-new-team/main.tf` — set project key, display name, repos, and groups. Run `terraform init && terraform apply`.

Each team is fully independent:
- Own state file (no cross-team conflicts)
- Own `terraform apply` (one team's failure doesn't block another)
- Own backend config (state isolation)

## Independent SDLC per team

Each `teams/<team>/` folder is a **fully independent Terraform root module**. Teams don't share state, don't block each other, and can evolve at their own pace.

| Aspect | Isolation |
|--------|-----------|
| State | Each team has its own `.tfstate` — no shared locking |
| Plan | Each team can declare a different repo layout in its own `main.tf` (today: docker + generic) |
| Apply | Teams apply independently — one failure doesn't block others |
| Review | Each team's changes go through their own PR / approval flow |
| Schedule | Team 1 can deploy daily, Team 2 weekly — no coordination needed |
| Backend | Each team can store state in a different path/bucket |

In CI, this means one pipeline per team folder (plus a separate platform pipeline):

```
platform/     →  init → plan → PR review → apply    (platform team)
teams/team1/  →  init → plan → PR review → apply    (independent)
teams/team2/  →  init → plan → PR review → apply    (independent)
```

### Backend configuration (required before shared / CI usage)

This is a **reference demo**. Out of the box, state is local — fine for a solo lab, **not OK for team/CI**.

Before any shared usage, edit `backend.tf` in each stack folder: uncomment **one** backend and set real values (S3, GCS, or azurerm).

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "jfrog-projects/team1/terraform.tfstate"   # unique per stack
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

Each stack must keep a **unique** state path so states never collide.

**Do not store this state inside the JFrog Platform this code manages.** This stack configures Artifactory repositories, Projects and Xray policies. Keeping its state on that same platform creates a circular dependency — a bad apply or a platform outage would lock you out of the state needed to fix it. Pick storage that stays available when the platform is down.

The legacy `backend "artifactory"` block is not an option either: it was deprecated in Terraform 1.2.3 and **removed in 1.3**, so it cannot be used with `required_version >= 1.5`.

## Prerequisites

- Groups referenced in `admin_groups` / `member_groups` must already exist in Artifactory
- The access token needs platform admin permissions
- Apply `platform/` before relying on the global policy / watch

## Providers

| Provider | Version | Used by |
|----------|---------|---------|
| `jfrog/artifactory` | `~> 12.11` | platform + teams |
| `jfrog/project` | `~> 1.9` | teams |
| `jfrog/xray` | `~> 3.1` | platform + teams |

## Requirements

- Terraform >= 1.5
- JFrog Platform with Projects and Xray enabled
