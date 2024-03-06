# Service Subnet NACL Rules

Create NACL rules appropriate for a service-specific subnet, where the ingress port and address range is known, and limited.
The egress rules created by this module will allow the full ephemeral port range (1024-65535) out to the values configured
in the `ipv4_cidr_block` and `ipv6_cidr_block` variables.

The NACL rule numbers used by this module will strive to stay above 30000, so that any case-specific rules have plenty of
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.39.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_network_acl_rule.egress-ipv4-tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.egress-ipv4-udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.egress-ipv6-tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.egress-ipv6-udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress-ipv4-tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress-ipv4-udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress-ipv6-tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress-ipv6-udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Toggle to create NACL rules for the value specified in ipv6\_cidr\_block | `bool` | `false` | no |
| <a name="input_ingress_tcp_ports"></a> [ingress\_tcp\_ports](#input\_ingress\_tcp\_ports) | List of TCP port numbers for creating ingress NACL rules | `list(number)` | `[]` | no |
| <a name="input_ingress_udp_ports"></a> [ingress\_udp\_ports](#input\_ingress\_udp\_ports) | List of UDP port numbers for creating ingress NACL rules | `list(number)` | `[]` | no |
| <a name="input_ipv4_cidr_block"></a> [ipv4\_cidr\_block](#input\_ipv4\_cidr\_block) | The IPv4 CIDR block to configure in IPv4-specific NACL rules, typically the VPC IPv4 value | `string` | n/a | yes |
| <a name="input_ipv6_cidr_block"></a> [ipv6\_cidr\_block](#input\_ipv6\_cidr\_block) | The IPv6 CIDR block to configure in IPv6-specific NACL rules, typically the VPC IPv6 value, if assigned | `string` | `null` | no |
| <a name="input_nacl_id"></a> [nacl\_id](#input\_nacl\_id) | The network ACL ID to create rules in | `string` | n/a | yes |

## Outputs

No outputs.


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
