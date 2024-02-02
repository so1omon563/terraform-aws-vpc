provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "name" {
  default = "tf-basic-usage-vpc"
}

variable "tags" {
  default = {
    example = "true"
  }
}

module "vpc" {
  source = "../../"
  name   = var.name
  tags   = var.tags
}
output "vpc" { value = module.vpc }
