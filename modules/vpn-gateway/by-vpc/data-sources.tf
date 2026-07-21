# This file is for data sources that may be required for the module to run.

# Get subnet IDs based on VPC ID
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Get route tables
data "aws_route_table" "route_tables" {
  for_each  = toset(data.aws_subnets.subnets.ids)
  subnet_id = each.value
}
