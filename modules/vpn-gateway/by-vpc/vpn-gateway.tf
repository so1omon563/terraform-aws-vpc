resource "aws_vpn_gateway" "vgw" {
  vpc_id = var.vpc_id
  tags   = merge(local.tags, { Name = format("%s-vgw", var.name) })

  amazon_side_asn = var.amazon_side_asn
}

resource "aws_vpn_gateway_attachment" "attachment" {
  vpc_id         = aws_vpn_gateway.vgw.vpc_id
  vpn_gateway_id = aws_vpn_gateway.vgw.id
}

resource "aws_vpn_gateway_route_propagation" "routes" {
  count          = length(local.route_tables_ids)
  route_table_id = local.route_tables_ids[count.index]
  vpn_gateway_id = aws_vpn_gateway_attachment.attachment.vpn_gateway_id
}
