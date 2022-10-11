resource "aws_vpc" "vpc" {
  # An AWS-provided /56 IPv6 CIDR block (can not configure address block or size)
  assign_generated_ipv6_cidr_block = local.vpc.enable_ipv6

  cidr_block           = local.vpc.cidr_block
  enable_dns_support   = local.vpc.enable_dns_support
  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  instance_tenancy     = local.vpc.instance_tenancy

  tags = merge(local.tags, { Name = format("%s", var.name) })
}
