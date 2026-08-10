module "team_project" {
  source = "../../modules/team_project"

  project_key          = "sampleteam"
  project_display_name = "Sample Team"
  project_description  = "Demo project: one project per team pattern"

  team_admin_groups  = ["sample-team-leads"]
  team_member_groups = ["sample-team-devs"]

  repositories = [
    {
      key          = "sampleteam-docker-dev-local"
      type         = "local"
      package_type = "docker"
      description  = "Docker images — development"
      environments = ["DEV"]
    },
    {
      key          = "sampleteam-docker-prod-local"
      type         = "local"
      package_type = "docker"
      description  = "Docker images — production"
      environments = ["PROD"]
    },
    {
      key          = "sampleteam-docker-remote"
      type         = "remote"
      package_type = "docker"
      description  = "Proxy to Docker Hub"
      url          = "https://registry-1.docker.io/"
      environments = ["DEV", "PROD"]
    },
    {
      key          = "sampleteam-docker-virtual"
      type         = "virtual"
      package_type = "docker"
      description  = "Single endpoint aggregating all Docker repos"
      members = [
        "sampleteam-docker-dev-local",
        "sampleteam-docker-prod-local",
        "sampleteam-docker-remote",
      ]
    },
  ]
}
