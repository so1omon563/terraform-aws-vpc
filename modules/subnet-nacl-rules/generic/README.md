# Generic Subnet NACL Rules

Create NACL rules appropriate for a generic/general-purpose subnet, where the ingress and egress port are generally well
known, but the networks accessing them are not.  This module creates NACL rules which allow ingress access from anywhere
to the ports provided in the `ingress_tcp_ports` and `ingress_udp_ports` input variables.  Ports specified in the
`egress_tcp_ports` and `egress_udp_ports` input variables are also used to create egress NACL rules which permit
output traffic to any destination for those ports.  The default setup for the input variables has empty values for the
ingress ports, and egress rules which allow TCP ports 80 and 443, and UDP port 123 (for NTP time sync).  Finally, the
module also creates NACL rules which allows all ingress and egress traffic between RFC 1918 (non-routable) addresses, and
any networks configured in the `extra_ipv4_cidr` and `ipv6_cidr` input variables.  Making that final bit more open will
help accommodate possible future changes in network connectivity (peering, additional VPC CIDR blocks, VPN) without
having to troubleshoot NACL layer issues.

The NACL rule numbers used by this module will strive to stay above 25000, so that any case-specific rules have plenty of
room to work.  It is suggested that any rules created outside of this module on the same NACL table use rule numbers lower
then 15000 to minimize the chance for conflict.
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base"></a> [base](#module\_base) | ../service | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_network_acl_rule.ipv4-tcp-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv4-tcp-ingress-ephemeral](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv4-udp-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv4-udp-ingress-ephemeral](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv6-tcp-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv6-tcp-ingress-ephemeral](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv6-udp-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv6-udp-ingress-ephemeral](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.vpc-ipv4-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.vpc-ipv4-ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.vpc-ipv6-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.vpc-ipv6-ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_egress_tcp_ports"></a> [egress\_tcp\_ports](#input\_egress\_tcp\_ports) | List of additional TCP port numbers for creating egress NACL rules, combined with values in `local.egress_udp_ports_defaults` - `[80, 443]` | `list(number)` | `[]` | no |
| <a name="input_egress_udp_ports"></a> [egress\_udp\_ports](#input\_egress\_udp\_ports) | List of additional UDP port numbers for creating egress NACL rules, combined with values in `local.egress_udp_ports_defaults` - `[123]` | `list(number)` | `[]` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Toggle to create NACL rules for the value specified in ipv6\_cidr\_block | `bool` | `false` | no |
| <a name="input_extra_ipv4_cidr"></a> [extra\_ipv4\_cidr](#input\_extra\_ipv4\_cidr) | List of additional CIDR blocks to grant full access NACL rules.<br>  Combined with values in `local.extra_ipv4_cidr_defaults` - `["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]` | `list(string)` | `[]` | no |
| <a name="input_ingress_tcp_ports"></a> [ingress\_tcp\_ports](#input\_ingress\_tcp\_ports) | List of TCP port numbers for creating ingress NACL rules | `list(number)` | `[]` | no |
| <a name="input_ingress_udp_ports"></a> [ingress\_udp\_ports](#input\_ingress\_udp\_ports) | List of UDP port numbers for creating ingress NACL rules | `list(number)` | `[]` | no |
| <a name="input_ipv6_cidr"></a> [ipv6\_cidr](#input\_ipv6\_cidr) | The IPv6 CIDR block to configure in IPv6-specific NACL rules, typically the VPC IPv6 value, if assigned | `string` | `null` | no |
| <a name="input_nacl_id"></a> [nacl\_id](#input\_nacl\_id) | The network ACL ID to create rules in | `any` | n/a | yes |

## Outputs

No outputs.


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
