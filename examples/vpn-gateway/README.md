# Standard VPC with IPv6

Usage examples can be found in the `*.tf` source files.

Example demonstrates a VPN Gateway in a VPC.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | so1omon563/vpc/aws//modules/vpn-gateway/by-route-table | 1.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | n/a |
| <a name="output_vpn"></a> [vpn](#output\_vpn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->