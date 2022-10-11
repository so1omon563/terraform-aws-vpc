locals {
  region               = data.aws_region.current.id
  account_id           = data.aws_caller_identity.current.account_id
  tags                 = var.tags
  create_natgw         = length(module.private_subnets.subnets) > 0 && length(module.public_subnets.subnets) > 0
  natgw_count_defaults = var.nat_gateway_count > 0 ? min(var.nat_gateway_count, length(module.public_subnets.subnets)) : length(module.public_subnets.subnets)
  natgw_count          = local.create_natgw ? local.natgw_count_defaults : 0
  short_az_id          = [for i in range(local.natgw_count) : format("%s", substr(module.public_subnets.subnets[i]["availability_zone"], -2, 2))]
  igw_count            = length(module.public_subnets.subnets) > 0 ? 1 : 0
  eigw_count           = length(module.private_subnets.subnets) > 0 && aws_vpc.vpc.assign_generated_ipv6_cidr_block ? 1 : 0
  all_ipv4             = "0.0.0.0/0"
  all_ipv6             = "::/0"
  # IPv6 allocation strategy: IPv6 subnet cidr must be a /64, so there is a maximum of 256 subnets for a VPC IPv6 block
  # public subnets  - assignments start at the beginning of the VPC IPv6 CIDR block and increment consecutively
  # private subnets - assignments start at the 32nd /64 cidr and increment consecutively
  pub_ipv6 = aws_vpc.vpc.assign_generated_ipv6_cidr_block ? cidrsubnets(aws_vpc.vpc.ipv6_cidr_block, [for i in var.public_cidrs : 8]...) : []
  pvt_ipv6 = aws_vpc.vpc.assign_generated_ipv6_cidr_block ? cidrsubnets(cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 4, 2), [for i in var.private_cidrs : 4]...) : []
  vpc_defaults = {
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "10.255.255.192/26"
    enable_dns_support               = true
    enable_dns_hostnames             = true
    instance_tenancy                 = "default"
  }
  vpc = merge(local.vpc_defaults, var.vpc)

}
