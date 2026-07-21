terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
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
  default = "tf-basic-usage-vpc"
}

variable "tags" {
  type = map(string)
  default = {
    example = "true"
  }
}

module "vpc" {
  source           = "../../"
  create_flow_logs = false
  name             = var.name
  tags             = var.tags
}
output "vpc" { value = module.vpc }
