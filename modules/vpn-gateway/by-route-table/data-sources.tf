# This file is for data sources that may be required for the module to run.

data "aws_route_table" "route_table" {
  route_table_id = var.route_table_ids[0]
}
