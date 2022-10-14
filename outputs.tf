locals {
  output_filter = [
    "id", "arn", "assign_generated_ipv6_cidr_block", "enable_dns_hostnames", "enable_dns_support", "ipv6_cidr_block",
    "private_ip", "public_ip", "subnet_id"
  ]
}

output "vpc_id" {
  description = "The ID of the VPC. Output separately for convenience."
  value       = aws_vpc.vpc.id
}

output "vpc" {
  description = "A collection of outputs from the created VPC."
  value = merge(
    {
      igw_id  = local.igw_count > 0 ? aws_internet_gateway.igw[0].id : null
      eigw_id = local.eigw_count > 0 ? aws_egress_only_internet_gateway.eigw[0].id : null
    },
    {
      for key, value in aws_vpc.vpc : key => value if contains(local.output_filter, key)
    }
  )
}

output "public_subnets" {
  description = "A list of the public subnet ids created by this module."
  value       = module.public_subnets.subnets
}

output "private_subnets" {
  description = "A list of the private subnet ids created by this module."
  value       = module.private_subnets.subnets
}

output "public_route_table_ids" {
  description = "A list of the public route table ids created by this module."
  value       = module.public_subnets.route_table_ids
}

output "private_route_table_ids" {
  description = "A list of the public route table ids created by this module."
  value       = module.private_subnets.route_table_ids
}

output "public_nacl" {
  description = "The ID of the publc NACL created by this module."
  value       = module.public_subnets.nacl
}

output "private_nacl" {
  description = "The ID of the private NACL created by this module."
  value       = module.private_subnets.nacl
}

output "nat_gateways" {
  description = "A list of the NAT gateway ids created by this module."
  value       = [for nat in aws_nat_gateway.natgw : { for key, value in nat : key => value if contains(local.output_filter, key) }]
}

output "tags" {
  description = "The tags of the VPC. Output separately here for convenience."
  value       = aws_vpc.vpc.tags
}

output "name_prefix" {
  description = "The name prefix of the VPC. Output separately here for convenience."
  value       = var.name
}

output "dhcp_options_id" {
  description = "The ID of the DHCP options set created by this module."
  value       = aws_vpc_dhcp_options.dhcp.id
}
