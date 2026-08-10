module "team_project" {
  source = "../../modules/team_project"

  project_key          = "team1"
  project_display_name = "Team 1"
  project_description  = "First team project"

  team_admin_groups  = ["team1-leads"]
  team_member_groups = ["team1-devs"]

  repositories = [
    {
      key          = "team1-docker-dev-local"
      type         = "local"
      package_type = "docker"
      description  = "Docker images — development"
      environments = ["DEV"]
    },
    {
      key          = "team1-docker-prod-local"
      type         = "local"
      package_type = "docker"
      description  = "Docker images — production"
      environments = ["PROD"]
    },
    {
      key          = "team1-docker-remote"
      type         = "remote"
      package_type = "docker"
      description  = "Proxy to Docker Hub"
      url          = "https://registry-1.docker.io/"
      environments = ["DEV", "PROD"]
    },
    {
      key          = "team1-docker-virtual"
      type         = "virtual"
      package_type = "docker"
      description  = "Single endpoint for all Docker repos"
      members = [
        "team1-docker-dev-local",
        "team1-docker-prod-local",
        "team1-docker-remote",
      ]
    },
  ]
}
