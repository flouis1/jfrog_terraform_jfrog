# GitLab OIDC

This example allows a gitlab workflow to assume the permissions of an existing service account user created in the platform via OIDC.
The service account's password is not stored in terraform state, so access can only be obtained via the integration.

This example is based on the documentation below.
You will need to adjust the claims.json as appropriate your repos and organisation(s).

- [JFrog Docs - OIDC Integration with GitLab](https://docs.jfrog.com/administration/docs/openid-connect-integration#integration-with-gitlab)
- [JFrog Docs - Sample GitLab Workflow](https://docs.jfrog.com/administration/docs/openid-connect-integration#sample-gitlab-workflow-yaml)

While this example scopes the token to the permissions assigned to a user managed by Terraform, other options include scoping to roles within a JFrog Project, groups, or full administrator rights.
See [jfrog/platform oidc_identity_mapping](https://registry.terraform.io/providers/jfrog/platform/latest/docs/resources/oidc_identity_mapping) for more examples and the full token spec.
