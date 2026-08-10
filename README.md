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

## State isolation

Each `teams/<team>/` folder is a separate Terraform root module with its own state.
Edit `backend.tf` in each team folder to point to a unique state path:

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "jfrog-projects/team1/terraform.tfstate"
    ...
  }
}
```

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
