locals {
  region           = data.aws_region.current.id
  account_id       = data.aws_caller_identity.current.account_id
  tags             = var.tags
  route_tables_ids = [for e in data.aws_route_table.route_tables : e.id]
}