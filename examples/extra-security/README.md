# Extra Security

Usage examples can be found in the `*.tf` source files.

Example demonstrates some common "slightly more secure" use cases for adding subnets with specific NACLs and endpoints.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion-nacl"></a> [bastion-nacl](#module\_bastion-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/generic | 1.0.0 |
| <a name="module_bastion-network"></a> [bastion-network](#module\_bastion-network) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_cache-network"></a> [cache-network](#module\_cache-network) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | so1omon563/vpc/aws//modules/gateway-endpoints//by-route-table | 1.0.0 |
| <a name="module_postgres-nacl"></a> [postgres-nacl](#module\_postgres-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/service | 1.0.0 |
| <a name="module_private-nacl"></a> [private-nacl](#module\_private-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/generic | 1.0.0 |
| <a name="module_public-nacl"></a> [public-nacl](#module\_public-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/generic | 1.0.0 |
| <a name="module_rds-network"></a> [rds-network](#module\_rds-network) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_redis-nacl"></a> [redis-nacl](#module\_redis-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/service | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion-network"></a> [bastion-network](#output\_bastion-network) | n/a |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
