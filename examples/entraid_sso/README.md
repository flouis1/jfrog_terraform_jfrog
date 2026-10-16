# Entra ID SSO

To configure Artifactory to use Microsoft's Entra ID for Single Sign On, you require both the SAML SSO and a SCIM token for user management. For more details on how to configure these in Azure, refer to the documentation below. This module only handles the configuration of the Artifactory platform.

- [JFrog Docs - SAML SSO](https://docs.jfrog.com/administration/docs/saml-sso)
- [JFrog Docs - SCIM](https://docs.jfrog.com/administration/docs/scim)

Note that [platform_saml_settings](https://registry.terraform.io/providers/jfrog/platform/latest/docs/resources/saml_settings) at the time of writing this readme can configure both Artifactory Self-Hosted and SaaS, but can only enable the configuration in Self-Hosted instances. SaaS customers must enable the integration via a manual api call once applied.

SCIM is configured on your provider's side, but will require a token which this Terraform module can generate. The token will be stored in state, so be sure access to this is restricted.
