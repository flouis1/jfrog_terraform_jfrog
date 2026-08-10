# Terraform — JFrog Project per Team

Demonstrates the **one project per team** pattern on JFrog Platform using Terraform.

Each team has its own Terraform state — isolated blast radius, no cross-team locking conflicts.

## Repository structure

```
.
├── modules/
│   └── team_project/           # Reusable module: project + repos + group assignments
└── teams/
    ├── _template/              # Copy this folder to onboard a new team
    ├── team1/                  # Team 1 — own state, own apply
    └── team2/                  # Team 2 — own state, own apply
```

## Quick start

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
| Plan | Team 1 can have Docker repos, Team 2 can have Maven + NuGet |
| Apply | Teams apply independently — one failure doesn't block others |
| Review | Each team's changes go through their own PR / approval flow |
| Schedule | Team 1 can deploy daily, Team 2 weekly — no coordination needed |
| Backend | Each team can store state in a different path/bucket |

In CI, this means one pipeline per team folder:

```
teams/team1/  →  init → plan → PR review → apply    (independent)
teams/team2/  →  init → plan → PR review → apply    (independent)
```

### Backend configuration (required before shared / CI usage)

This is a **reference demo**. Out of the box, state is local — fine for a solo lab, **not OK for team/CI**.

Before any shared usage, edit `backend.tf` in each team folder: uncomment **one** backend and set real values. Prefer **Artifactory** (state in a Generic repo on the same platform). S3 / GCS are alternatives if you already have cloud storage.

```hcl
# Recommended — Artifactory Generic repo
terraform {
  backend "artifactory" {
    url     = "https://your-instance.jfrog.io/artifactory"
    repo    = "terraform-state"
    subpath = "jfrog-projects/team1"   # unique per team
  }
}
```

Each team must keep a **unique** `subpath` / `key` so states never collide.

## Prerequisites

- Groups referenced in `admin_groups` / `member_groups` must already exist in Artifactory
- The access token needs platform admin permissions

## Providers

| Provider | Version | Purpose |
|----------|---------|---------|
| `jfrog/artifactory` | `~> 12.11` | Repository management |
| `jfrog/project` | `~> 1.9` | Project, group, and repository assignment |

## Requirements

- Terraform >= 1.5
- JFrog Platform with Projects enabled
