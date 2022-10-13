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

  public_cidrs = []

  name = "example-private-only-vpc"
  tags = {
    example = "true"
  }
}

output "network" {
  value = module.vpc
}
