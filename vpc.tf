resource "aws_vpc" "vpc" {
  #checkov:skip=CKV2_AWS_11:"Ensure VPC flow logging is enabled in all VPCs" - Since this is a re-usable module, this needs to be able to be overridden.

  assign_generated_ipv6_cidr_block = local.vpc.assign_generated_ipv6_cidr_block

  cidr_block           = local.vpc.cidr_block
  enable_dns_support   = local.vpc.enable_dns_support
  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  instance_tenancy     = local.vpc.instance_tenancy

  tags = merge(local.tags, { Name = format("%s", var.name) })
}
