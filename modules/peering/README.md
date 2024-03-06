# VPC Peering Module

Create the VPC Peering Connection resources between 2 VPCs.  This module supports peering VPCs within or across regions.
The module supports peering VPCs in separate AWS accounts, as long as the user has the necessary IAM permissions to
manage VPC Peering Connections in both accounts.

This module only manages the actual VPC Peering Connection resource.  It is up to the user to modify the route tables
for the peered VPCs, as the decision of which resources to share across the peering connection are unique to each situation.

The module uses aliased providers to allow for distinct configuration of the requester and accepter side of the peering
connection, including configuring peering across regions and across accounts.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.39.1 |
| <a name="provider_aws.accepter"></a> [aws.accepter](#provider\_aws.accepter) | 5.39.1 |
| <a name="provider_aws.requester"></a> [aws.requester](#provider\_aws.requester) | 5.39.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_peering_connection.pcx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.acp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_vpc_peering_connection_options.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_vpc_peering_connection_options.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_caller_identity.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accepter_vpc_id"></a> [accepter\_vpc\_id](#input\_accepter\_vpc\_id) | The ID of the accepter VPC | `string` | n/a | yes |
| <a name="input_allow_remote_dns"></a> [allow\_remote\_dns](#input\_allow\_remote\_dns) | Allow resolution of public DNS hostnames to private IP addresses across the peering connection | `bool` | `false` | no |
| <a name="input_auto_accept"></a> [auto\_accept](#input\_auto\_accept) | Automatically accept the VPC peering connection request | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_requester_vpc_id"></a> [requester\_vpc\_id](#input\_requester\_vpc\_id) | The ID of the requester VPC | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering_connection"></a> [peering\_connection](#output\_peering\_connection) | A collection of outputs from the created VPC Peering Connection. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
