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

  name = "example-secondary-cidr-vpc"
  tags = {
    example = "true"
  }
}

# resource "aws_vpc_ipv4_cidr_block_association" "cidr" {
#   vpc_id     = module.vpc.vpc_id
#   cidr_block = "10.0.0.0/16"
# }

module "secondary_cidr" {
  source = "../../modules/additional-cidr-block-association"

  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.0.0/16"
}

module "lambda_subnets" {
  source      = "../../modules/subnets"
  vpc_id      = module.vpc.vpc_id
  name        = module.vpc.name_prefix
  subnet_type = "lambda"
  tags        = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(module.secondary_cidr.cidr_block_association.cidr_block, 8, 8, 8, 8)
}

output "network" {
  value = module.vpc
}

output "secondary_cidr" {
  value = module.secondary_cidr
}

output "lambda_subnets" {
  value = module.lambda_subnets
}
