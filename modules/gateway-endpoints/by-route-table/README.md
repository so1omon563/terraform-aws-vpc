# Gateway Endpoints by Route Table

Create S3 and DynamoDB gateway endpoint resources in a VPC - and associated routes in the provided route tables, to allow private communication to those AWS services.

This resource should be used if you want to add the gateway endpoints only to specific route tables and exclude others.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route_table.route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_policy"></a> [dynamodb\_policy](#input\_dynamodb\_policy) | Optional IAM policy to attach to the endpoint that controls access to DynamoDB | `any` | `null` | no |
| <a name="input_dynamodb_route_table_ids"></a> [dynamodb\_route\_table\_ids](#input\_dynamodb\_route\_table\_ids) | List of route table IDs to associate with the DynamoDB endpoint | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_s3_policy"></a> [s3\_policy](#input\_s3\_policy) | Optional IAM policy to attach to the endpoint that controls access to S3 | `any` | `null` | no |
| <a name="input_s3_route_table_ids"></a> [s3\_route\_table\_ids](#input\_s3\_route\_table\_ids) | List of route table IDs to associate with the S3 endpoint | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb"></a> [dynamodb](#output\_dynamodb) | A collection of outputs from the created DynamoDB Gateway Endpoint. |
| <a name="output_s3"></a> [s3](#output\_s3) | A collection of outputs from the created S3 Gateway Endpoint. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
