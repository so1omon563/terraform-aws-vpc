# This file is for data sources that may be required for the module to run.

data "aws_region" "current" {}

data "aws_route_table" "route_tables" {
  route_table_id = coalesce(concat(var.dynamodb_route_table_ids, var.s3_route_table_ids)...)
}
