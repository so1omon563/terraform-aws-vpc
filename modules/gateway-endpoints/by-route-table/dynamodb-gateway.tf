resource "aws_vpc_endpoint" "dynamodb" {
  service_name = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  vpc_id       = data.aws_route_table.route_tables.vpc_id
  policy       = var.dynamodb_policy
  tags         = merge(local.tags, { Name = format("%s-dynamodb", var.name) })

  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  count           = length(var.dynamodb_route_table_ids)
  route_table_id  = var.dynamodb_route_table_ids[count.index]
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}
