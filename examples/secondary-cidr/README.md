# Secondary CIDR Block

Usage examples can be found in the `*.tf` source files.

Example demonstrates adding a secondary CIDR block to a VPC, and then creating subnets within that CIDR block.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_subnets"></a> [lambda\_subnets](#module\_lambda\_subnets) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_secondary_cidr"></a> [secondary\_cidr](#module\_secondary\_cidr) | so1omon563/vpc/aws//modules/additional-cidr-block-association | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_subnets"></a> [lambda\_subnets](#output\_lambda\_subnets) | n/a |
| <a name="output_network"></a> [network](#output\_network) | n/a |
| <a name="output_secondary_cidr"></a> [secondary\_cidr](#output\_secondary\_cidr) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
