terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

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
  type    = string
  default = "tf-with-ipv6-vpc"
}

variable "tags" {
  type = map(string)
  default = {
    example = "true"
  }
}
variable "vpc" {
  type = map(string)
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
