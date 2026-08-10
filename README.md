# Terraform — JFrog Project per Team

Demonstrates the **one project per team** pattern on JFrog Platform using Terraform.

Each team gets an isolated JFrog Project containing its own repositories, with group-based permissions scoped to that project.

## Repository structure

```
.
├── modules/
│   └── team_project/       # Reusable module: creates a project + repos + group assignments
└── teams/
    └── sample-team/        # Example: one team stack targeting psemea.jfrog.io
```

## Quick start

```bash
cd teams/sample-team
export JFROG_ACCESS_TOKEN="<your-token>"
terraform init
terraform plan
terraform apply
```

## How it works

1. The `team_project` module creates a JFrog **Project** with admin privileges.
2. Repositories are created and assigned to the project via `project_repository`.
3. Groups are assigned roles within the project (`Project Admin` or `Developer`).
4. Each team stack is independent — its own state, its own variables.

## Adding a new team

1. Copy `teams/sample-team/` to `teams/<new-team>/`.
2. Edit `main.tf` — set the project key, display name, repos, and groups.
3. Run `terraform init && terraform apply`.

## Providers

| Provider | Version | Purpose |
|----------|---------|---------|
| `jfrog/artifactory` | `~> 12.11` | Repository management |
| `jfrog/project` | `~> 1.9` | Project, group, and repository assignment |

## Authentication

Set the `JFROG_ACCESS_TOKEN` environment variable. The token needs platform admin permissions to create projects and repositories.

## Requirements

- Terraform >= 1.5
- JFrog Platform with Projects enabled
- Access token with admin privileges
