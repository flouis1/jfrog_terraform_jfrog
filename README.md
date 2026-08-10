# Terraform — JFrog Project per Team

Demonstrates the **one project per team** pattern on JFrog Platform using Terraform.

Teams are declared in a single `teams.yaml` file. Terraform loops over all entries — no code changes needed to onboard a new team.

## Repository structure

```
.
├── main.tf                 # for_each over teams.yaml → instantiates module
├── teams.yaml              # ALL teams defined here (add/remove teams, that's it)
├── variables.tf            # jfrog_url
├── providers.tf
├── versions.tf
├── outputs.tf
├── terraform.tfvars.example
└── modules/
    └── team_project/       # Reusable module: project + repos + group assignments
```

## Quick start

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars — set your JFrog Platform URL

export JFROG_ACCESS_TOKEN="<your-admin-token>"
terraform init
terraform plan
terraform apply
```

## Adding a new team

Just add an entry in `teams.yaml`:

```yaml
- project_key: charlie
  display_name: "Team Charlie"
  description: "Data engineering team"
  admin_groups:
    - charlie-leads
  member_groups:
    - charlie-devs
  repositories:
    - key: charlie-docker-dev-local
      type: local
      package_type: docker
      description: "Docker images — development"
      environments: ["DEV"]
    - key: charlie-docker-prod-local
      type: local
      package_type: docker
      description: "Docker images — production"
      environments: ["PROD"]
    - key: charlie-docker-remote
      type: remote
      package_type: docker
      description: "Proxy to Docker Hub"
      url: "https://registry-1.docker.io/"
      environments: ["DEV", "PROD"]
    - key: charlie-docker-virtual
      type: virtual
      package_type: docker
      description: "Single endpoint for all Docker repos"
      members:
        - charlie-docker-dev-local
        - charlie-docker-prod-local
        - charlie-docker-remote
```

Then `terraform apply`. Done.

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
