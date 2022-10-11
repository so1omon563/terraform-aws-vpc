resource "aws_route" "nat" {
  count          = local.natgw_count > 0 ? length(module.private_subnets.route_table_ids) : 0
  route_table_id = module.private_subnets.route_table_ids[count.index]
  nat_gateway_id = element(aws_nat_gateway.natgw, count.index).id

  destination_cidr_block = local.all_ipv4

  timeouts {
    create = "5m"
    delete = "5m"
  }
}
