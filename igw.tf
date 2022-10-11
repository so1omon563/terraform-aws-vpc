
resource "aws_internet_gateway" "igw" {
  count  = local.igw_count
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.tags, { Name = format("%s", var.name) })
}

resource "aws_route" "igw_ipv4" {
  count          = local.igw_count > 0 ? length(module.public_subnets.route_table_ids) : 0
  route_table_id = module.public_subnets.route_table_ids[count.index]
  gateway_id     = aws_internet_gateway.igw[0].id

  destination_cidr_block = local.all_ipv4
}

resource "aws_route" "igw_ipv6" {
  count          = local.igw_count > 0 && aws_vpc.vpc.assign_generated_ipv6_cidr_block ? length(module.public_subnets.route_table_ids) : 0
  route_table_id = module.public_subnets.route_table_ids[count.index]
  gateway_id     = aws_internet_gateway.igw[0].id

  destination_ipv6_cidr_block = local.all_ipv6
}

resource "aws_egress_only_internet_gateway" "eigw" {
  count  = local.eigw_count
  vpc_id = aws_vpc.vpc.id
  tags   = local.tags
}

resource "aws_route" "eigw" {
  count          = local.eigw_count > 0 ? length(module.private_subnets.route_table_ids) : 0
  route_table_id = module.private_subnets.route_table_ids[count.index]

  egress_only_gateway_id      = aws_egress_only_internet_gateway.eigw[0].id
  destination_ipv6_cidr_block = local.all_ipv6
}
