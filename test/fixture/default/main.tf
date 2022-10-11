variable "name" {}

variable "tags" {}

provider "aws" {
  default_tags {
    tags = var.tags
  }
}

module "vpc" {
  source = "../../../"
  name   = "kitchen-default-vpc"
  tags   = { example = "true" }

  vpc = {
    enable_ipv6 = false
  }
}
output "vpc" { value = module.vpc }

module "vpc-ipv6" {
  source = "../../../"
  name   = "kitchen-default-ipv6-vpc"
  tags   = { example = "true" }

  vpc = {
    enable_ipv6 = true
  }
}
output "vpc-ipv6" { value = module.vpc-ipv6 }
