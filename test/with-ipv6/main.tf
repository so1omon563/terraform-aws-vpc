provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "name" {
  default = "tf-with-ipv6-vpc"
}

variable "tags" {
  default = {
    example = "true"
  }
}
variable "vpc" {
  default = {
    assign_generated_ipv6_cidr_block = true
  }
}
module "vpc" {
  source = "../../"
  name   = var.name
  tags   = var.tags
  vpc    = var.vpc
}
output "vpc" { value = module.vpc }
