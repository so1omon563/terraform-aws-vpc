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

  private_cidrs = []

  name = "example-public-only-vpc"
  tags = {
    example = "true"
  }
}

output "network" {
  value = module.vpc
}
