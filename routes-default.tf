# Adopt VPC's default Route Table into TF, which removes all routes except "local" route
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  tags                   = merge(local.tags, { Name = format("%s-default", var.name) })
}
