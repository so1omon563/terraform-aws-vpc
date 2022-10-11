locals {
  output_filter = [
    "id", "arn", "assign_generated_ipv6_cidr_block", "enable_dns_hostnames", "enable_dns_support", "ipv6_cidr_block",
    "private_ip", "public_ip", "subnet_id"
  ]
}

output "vpc_id" { value = aws_vpc.vpc.id }

output "vpc" {
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
  value = module.public_subnets.subnets
}

output "private_subnets" {
  value = module.private_subnets.subnets
}

output "public_route_table_ids" {
  value = module.public_subnets.route_table_ids
}

output "private_route_table_ids" {
  value = module.private_subnets.route_table_ids
}

output "public_nacl" {
  value = module.public_subnets.nacl
}

output "private_nacl" {
  value = module.private_subnets.nacl
}

output "nat_gateways" {
  value = [for nat in aws_nat_gateway.natgw : { for key, value in nat : key => value if contains(local.output_filter, key) }]
}

output "tags" {
  value = aws_vpc.vpc.tags
}

output "name_prefix" {
  value = var.name
}

output "dhcp_options_id" {
  value = aws_vpc_dhcp_options.dhcp.id
}
