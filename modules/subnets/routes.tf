resource "aws_route_table" "route_table" {
  count  = var.isolate_route_tables ? length(aws_subnet.subnet) : length(aws_subnet.subnet) > 0 ? 1 : 0
  vpc_id = aws_subnet.subnet[count.index].vpc_id
  tags   = var.isolate_route_tables ? merge(aws_subnet.subnet[count.index].tags, { Name = format("%s-%s-%s", var.name, var.subnet_type, element(local.az_short_id, count.index)) }, { network = var.map_public_ip_on_launch == true ? "public" : "private" }) : merge(local.tags, { Name = format("%s-%s", var.name, var.subnet_type) }, { network = var.map_public_ip_on_launch == true ? "public" : "private" })
}

resource "aws_route_table_association" "route" {
  count          = length(aws_subnet.subnet)
  route_table_id = element(aws_route_table.route_table[*].id, count.index)
  subnet_id      = aws_subnet.subnet[count.index].id
}
