locals {
  cidr_block        = "10.20.32.0/20"
  restrict_nacls    = true
  nat_gateway_count = 1
}

provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

module "vpc" {
  source  = "so1omon563/vpc/aws"
  version = "1.0.0"

  vpc = {
    cidr_block = local.cidr_block
  }
  restrict_nacls    = local.restrict_nacls
  nat_gateway_count = 1

  public_cidrs  = cidrsubnets(local.cidr_block, 6, 6, 6)
  private_cidrs = cidrsubnets(cidrsubnet(local.cidr_block, 1, 1), 2, 2, 2)

  name = "example-extra-security-vpc"

  tags = {
    example = "true"
  }
}

output "vpc" {
  value = module.vpc
}
