resource "aws_vpc_endpoint" "s3" {
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_id       = var.vpc_id
  policy       = var.s3_policy
  tags         = merge(local.tags, { Name : format("%s-s3", var.name) })

  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  count           = length(local.route_tables_ids)
  route_table_id  = local.route_tables_ids[count.index]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
