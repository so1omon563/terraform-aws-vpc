# VPC

Create a basic/standard VPC suitable for most cases.  The submodules allow extension of this root-level VPC to enable
further customization of Subnets, NACLs, Gateway Endpoints, DHCP options, and VPN gateways.

In the basic configuration this module will create the public and private subnets (including route tables and NACL tables
with open access), the associated Internet and NAT gateways, manage the VPC flow log retention period, and resources
necessary to enable IPv6 (if configured).  Additionally, the VPC default security group, route table, and NACL table
resources will be adopted into Terraform management, and stripped of their default configuration.

The default CIDR block is created in the 10.0.0.0/8 address space, so if a VPC is created in this default configuration,
but later needs to connect to another network, secondary IPv4 address blocks can be configured for the VPC with
the appropriate ranges.  A VPC created outside of the 10.x.x.x network range is not compatible with connectivity to networks outside of that range due to
limitations on the address range which can be used for secondary IPv4 CIDR block configurations. See
<https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html#add-cidr-block-restrictions> for more information on
these limitations.

Please review the available submodules and examples to determine what additional resources may be required for your use case.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_logs"></a> [logs](#module\_logs) | ./modules/flow-logs | n/a |
| <a name="module_private_subnets"></a> [private\_subnets](#module\_private\_subnets) | ./modules/subnets | n/a |
| <a name="module_public_subnets"></a> [public\_subnets](#module\_public\_subnets) | ./modules/subnets | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_network_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_egress_only_internet_gateway.eigw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway) | resource |
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.eigw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.igw_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.igw_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.dhcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.dhcp-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_flow_logs"></a> [create\_flow\_logs](#input\_create\_flow\_logs) | Whether or not to create flow logs for the VPC. Defaults to `true`, per AWS best practices. | `bool` | `true` | no |
| <a name="input_flow_logs_kms_key_id"></a> [flow\_logs\_kms\_key\_id](#input\_flow\_logs\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested. | `string` | `null` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | The number of days to retain flow log records. | `number` | `365` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_nat_gateway_count"></a> [nat\_gateway\_count](#input\_nat\_gateway\_count) | Total number of NAT gateways to create. If set to `-1`, then a NAT gateway will be created per public subnet. If set to `0`, then no NAT gateways will be created. If set to another number, then that number of NAT gateways will be created, in order from the first available public subnet. | `number` | `-1` | no |
| <a name="input_private_cidrs"></a> [private\_cidrs](#input\_private\_cidrs) | List of IPv4 CIDR blocks used for private subnets | `list(string)` | <pre>[<br>  "10.255.255.224/28",<br>  "10.255.255.240/28"<br>]</pre> | no |
| <a name="input_public_cidrs"></a> [public\_cidrs](#input\_public\_cidrs) | List of IPv4 CIDR blocks used for public subnets | `list(string)` | <pre>[<br>  "10.255.255.192/28",<br>  "10.255.255.208/28"<br>]</pre> | no |
| <a name="input_restrict_nacls"></a> [restrict\_nacls](#input\_restrict\_nacls) | If this is set to `true`, network ACL resource created for these subnets will be left empty and deny all ingress and egress traffic. This is useful if you want to manage NACLs outside of this module. If set to `false`, `allow all` ingress and egress NACL rules are created for the subnets | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | A map of VPC properties. Options in `local.vpc_defaults` can be overridden here.<br>  Default values are:<pre>vpc_defaults = {<br>    assign_generated_ipv6_cidr_block = false<br>    cidr_block                       = "10.255.255.192/26"<br>    enable_dns_support               = true<br>    enable_dns_hostnames             = true<br>    instance_tenancy                 = "default"<br>  }</pre>See [aws\_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) for more information on the options | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dhcp_options_id"></a> [dhcp\_options\_id](#output\_dhcp\_options\_id) | n/a |
| <a name="output_name_prefix"></a> [name\_prefix](#output\_name\_prefix) | n/a |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | n/a |
| <a name="output_private_nacl"></a> [private\_nacl](#output\_private\_nacl) | n/a |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_nacl"></a> [public\_nacl](#output\_public\_nacl) | n/a |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
