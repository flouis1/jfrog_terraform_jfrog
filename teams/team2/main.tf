module "team_project" {
  source = "../../modules/team_project"

  project_key          = "team2"
  project_display_name = "Team 2"
  project_description  = "Second team project"

  team_admin_groups  = ["team2-leads"]
  team_member_groups = ["team2-devs"]

  # Attach platform baseline; add team-only policies via team_security_policy_names
  global_security_policy_name = "policy-security-baseline"

  repositories = [
    {
      key          = "team2-docker-dev-local"
      type         = "local"
      package_type = "docker"
      description  = "Docker images — development"
      environments = ["DEV"]
    },
    {
      key          = "team2-docker-prod-local"
      type         = "local"
      package_type = "docker"
      description  = "Docker images — production"
      environments = ["PROD"]
    },
    {
      key          = "team2-docker-remote"
      type         = "remote"
      package_type = "docker"
      description  = "Proxy to Docker Hub"
      url          = "https://registry-1.docker.io/"
      environments = ["DEV", "PROD"]
    },
    {
      key          = "team2-docker-virtual"
      type         = "virtual"
      package_type = "docker"
      description  = "Single endpoint for all Docker repos"
      members = [
        "team2-docker-dev-local",
        "team2-docker-prod-local",
        "team2-docker-remote",
      ]
    },
  ]
}
