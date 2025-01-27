# Sample Terraform Project

This project is a sample terraform stack that deploy the *shared_config* terraform module.

## Prerequisites

- An up and running JFrog platform
- Terraform v.1.9.8 or higher

## Usage

Set the environment variable ```JFROG_ACCESS_TOKEN``` to allow Terraform to deploy resources

    export JFROG_ACCESS_TOKEN=<ACCESS_TOKEN>

Update the ```terraform.tfvars``` file to set your JFrog URL

The current project uses a local backend. **This is not recommended for production workloads.**

To deploy JFrog resources, use the following commands:

    terraform init
    terraform apply

To destroy all resources managed by terraform, use the following command:

    terraform destroy


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_artifactory"></a> [artifactory](#requirement\_artifactory) | 12.5.1 |
| <a name="requirement_project"></a> [project](#requirement\_project) | 1.9.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_shared_configuration"></a> [shared\_configuration](#module\_shared\_configuration) | ../modules/shared_config | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_jfrog_url"></a> [jfrog\_url](#input\_jfrog\_url) | JFrog URL ex: https://test.jfrog.io | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->