resource "aws_vpn_gateway" "vgw" {
  vpc_id = data.aws_route_table.route_table.vpc_id
  tags   = merge(local.tags, { Name = format("%s-vgw", var.name) })

  amazon_side_asn = var.amazon_side_asn
}

resource "aws_vpn_gateway_attachment" "attachment" {
  vpc_id         = aws_vpn_gateway.vgw.vpc_id
  vpn_gateway_id = aws_vpn_gateway.vgw.id
}

resource "aws_vpn_gateway_route_propagation" "routes" {
  count          = length(var.route_table_ids)
  route_table_id = var.route_table_ids[count.index]
  vpn_gateway_id = aws_vpn_gateway_attachment.attachment.vpn_gateway_id
}
