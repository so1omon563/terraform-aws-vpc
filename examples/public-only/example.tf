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

  private_cidrs = []

  name = "example-public-only-vpc"
  tags = {
    example = "true"
  }
}

output "network" {
  value = module.vpc
}
