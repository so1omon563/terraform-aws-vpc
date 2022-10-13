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

  name = "example-vpc"
  tags = {
    example = "true"
  }
}
output "vpc" { value = module.vpc }
