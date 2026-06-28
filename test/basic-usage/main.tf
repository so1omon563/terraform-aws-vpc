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
  default = "tf-basic-usage-vpc"
}

variable "tags" {
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
