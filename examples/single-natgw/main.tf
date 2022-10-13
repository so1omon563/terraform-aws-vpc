provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

module "vpc" {
  source = "../../"

  nat_gateway_count = 1

  name = "example-single-natgw-vpc"
  tags = {
    example = "true"
  }
}

output "network" {
  value = module.vpc
}
