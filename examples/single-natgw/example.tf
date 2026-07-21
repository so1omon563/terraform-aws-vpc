terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
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
  version = "2.2.0"

  nat_gateway_count = 1

  name = "example-single-natgw-vpc"
  tags = {
    example = "true"
  }
}

output "network" {
  value = module.vpc
}
