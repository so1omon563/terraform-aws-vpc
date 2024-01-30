# Subnets

Create additional subnets in a VPC beyond what is already available to configure as public and private subnets in the
root VPC module.  This is useful for configuring service-specific subnets, or creating subnets after the addition of
a secondary IPv4 CIDR allocation for a VPC.
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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_network_acl.nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.ipv4_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv4_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv6_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ipv6_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route_table.route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_availability_zones.az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ipv4_cidr_blocks"></a> [ipv4\_cidr\_blocks](#input\_ipv4\_cidr\_blocks) | List of IPv4 cidr blocks to configure subnets | `list(string)` | n/a | yes |
| <a name="input_ipv6_cidr_blocks"></a> [ipv6\_cidr\_blocks](#input\_ipv6\_cidr\_blocks) | List of IPv6 cidr blocks to configure subnets. If specified, length must match ipv4\_cidr\_blocks | `list(string)` | `[]` | no |
| <a name="input_isolate_route_tables"></a> [isolate\_route\_tables](#input\_isolate\_route\_tables) | If `true`, a route table will be created for each subnet, otherwise a single route table will be created for all subnets managed by this module | `bool` | `false` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | If true, automatically assign a public IPv4 address to resources in the subnets. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_restrict_nacls"></a> [restrict\_nacls](#input\_restrict\_nacls) | If this is set to `true`, network ACL resource created for these subnets will be left empty and deny all ingress and egress traffic. This is useful if you want to manage NACLs outside of this module. If set to `false`, `allow all` ingress and egress NACL rules are created for the subnets | `bool` | `false` | no |
| <a name="input_subnet_type"></a> [subnet\_type](#input\_subnet\_type) | A value that will be appended to the `var.name` to name the subnet. Will also be used to name the route table if `var.isolate_route_tables` is `true` | `string` | `"subnet"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID for the subnets | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nacl"></a> [nacl](#output\_nacl) | A collection of outputs from the NACL created by this module. |
| <a name="output_route_table_ids"></a> [route\_table\_ids](#output\_route\_table\_ids) | A list of the route table ids created by this module. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A collection of outputs from the created Subnets. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
