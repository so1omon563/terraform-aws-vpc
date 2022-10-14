# VPC Peering Across Region

Usage examples can be found in the `*.tf` source files.

Example demonstrates creating a VPC Peering Connection across regions within the same account.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.accepter"></a> [aws.accepter](#provider\_aws.accepter) | 4.34.0 |
| <a name="provider_aws.requester"></a> [aws.requester](#provider\_aws.requester) | 4.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acp"></a> [acp](#module\_acp) | so1omon563/vpc/aws | 1.0.0 |
| <a name="module_pcx"></a> [pcx](#module\_pcx) | so1omon563/vpc/aws//modules/peering | 1.0.0 |
| <a name="module_req"></a> [req](#module\_req) | so1omon563/vpc/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.acp_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.req_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering"></a> [peering](#output\_peering) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
