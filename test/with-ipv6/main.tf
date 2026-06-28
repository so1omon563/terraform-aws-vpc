provider "aws" {
  skip_credentials_validation = true
  skip_requesting_account_id  = true

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
  source           = "../../"
  create_flow_logs = false
  name             = var.name
  tags             = var.tags
  vpc              = var.vpc
}
output "vpc" { value = module.vpc }
