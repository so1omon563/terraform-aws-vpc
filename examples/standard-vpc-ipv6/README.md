# Standard VPC with IPv6

Usage examples can be found in the `*.tf` source files.

Example demonstrates creating a VPC using default values with IPv6 support, and Gateway Endpoints for S3 and DynamoDB.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | so1omon563/vpc/aws//modules/gateway-endpoints/by-route-table | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
