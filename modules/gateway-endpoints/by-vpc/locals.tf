locals {
  tags             = var.tags
  route_tables_ids = [for e in data.aws_route_table.route_tables : e.id]
}
