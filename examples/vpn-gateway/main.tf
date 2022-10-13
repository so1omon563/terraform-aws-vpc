provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

locals {
  cidr_block = "10.169.240.0/20"
}

module "vpc" {
  source = "../../"

  vpc = {
    cidr_block = local.cidr_block
  }

  public_cidrs  = cidrsubnets(local.cidr_block, 4, 4, 4)
  private_cidrs = cidrsubnets(cidrsubnet(local.cidr_block, 1, 1), 2, 2, 2)

  name = "example-vpn-vpc"

  tags = {
    example = "true"
  }
}

module "vpn" {
  source = "../../modules/vpn-gateway/by-route-table/"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  route_table_ids = concat(module.vpc.public_route_table_ids[*], module.vpc.private_route_table_ids[*])
}

output "network" {
  value = module.vpc
}

output "vpn" {
  value = module.vpn
}
