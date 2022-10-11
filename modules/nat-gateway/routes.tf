resource "aws_route" "nat" {
  count          = local.natgw_count > 0 ? length(local.private_route_tables_ids) : 0
  route_table_id = element(local.private_route_tables_ids, count.index)
  nat_gateway_id = element(aws_nat_gateway.natgw, count.index).id

  destination_cidr_block = local.all_ipv4
}
