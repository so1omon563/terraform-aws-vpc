# This file is for data sources that may be required for the module to run.

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


data "aws_availability_zones" "az" {
  state = "available"
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    network = "public"
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public_subnets.ids)
  id       = each.value
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    network = "private"
  }
}
data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}

# Get Private route tables
data "aws_route_table" "private" {
  for_each  = toset(data.aws_subnets.private_subnets.ids)
  subnet_id = each.value
}
