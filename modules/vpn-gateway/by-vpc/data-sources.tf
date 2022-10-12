# This file is for data sources that may be required for the module to run.

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Get  Subnet IDs based on VPC ID
data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}
# Get route tables
data "aws_route_table" "route_tables" {
  for_each  = data.aws_subnet_ids.subnets.ids
  subnet_id = each.value
}