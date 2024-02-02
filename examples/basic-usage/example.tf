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

  name = "example-vpc"
  tags = {
    example = "true"
  }
}
output "vpc" { value = module.vpc }
