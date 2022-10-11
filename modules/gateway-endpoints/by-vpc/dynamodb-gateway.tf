resource "aws_vpc_endpoint" "dynamodb" {
  service_name = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  vpc_id       = var.vpc_id
  policy       = var.dynamodb_policy
  tags         = merge(local.tags, { Name = format("%s-dynamodb", var.name) })

  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  count           = length(local.route_tables_ids)
  route_table_id  = local.route_tables_ids[count.index]
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}
