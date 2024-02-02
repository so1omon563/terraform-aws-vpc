locals {
  cidr_block     = "10.20.32.0/20"
  restrict_nacls = true
}

provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "tags" {
  default = {
    example = "true"
  }
}
module "vpc" {
  source = "../../"

  vpc = {
    cidr_block = local.cidr_block
  }
  public_cidrs  = []
  private_cidrs = []

  name = "example-custom-subnets-vpc"

  tags = var.tags
}

output "vpc" {
  value = module.vpc
}

## Create custom named public subnets.

module "custom-network" {
  source = "../..//modules/subnets"

  vpc_id = module.vpc.vpc_id

  subnet_name_overrides = [
    "custom-1",
    "custom-2"
  ]
  route_table_name_override = "custom-routes"
  tags                      = var.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr_block, 7, 8), 1, 1)

  map_public_ip_on_launch = true
}

output "custom-network" {
  value = module.custom-network
}

# Since we created a VPC without any default Public subnets, we need to create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags   = merge(var.tags, { Name = "custom-igw" })
}

# Need to add a route to the custom network to the public route table
resource "aws_route" "ipv4_default" {
  depends_on     = [aws_internet_gateway.igw]
  count          = length(module.custom-network.route_table_ids)
  route_table_id = module.custom-network.route_table_ids[count.index]
  gateway_id     = aws_internet_gateway.igw.id

  destination_cidr_block = "0.0.0.0/0"
}
