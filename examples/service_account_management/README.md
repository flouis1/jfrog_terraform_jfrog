# Service Account Management

A service account can be provisioned in Artifactory using this example. By default, it will be added to the `readers` group, which is provisioned by default in an artifactory instance and grants read-only perms to all repos. For CI integrations, the groups and permissions should be adjusted to grant read and deploy access to the required repositories.

- [JFrog Docs - Manage Users](https://docs.jfrog.com/administration/docs/manage-users-2)
- [JFrog Docs - Manage Groups](https://docs.jfrog.com/administration/docs/manage-groups)
- [JFrog Docs - Access Tokens](https://docs.jfrog.com/administration/docs/access-tokens)

The user token will be stored in Terraform state, so be sure access to this is restricted. Consider storing the token output in a secret manager such as Vault after the initial apply instead.
