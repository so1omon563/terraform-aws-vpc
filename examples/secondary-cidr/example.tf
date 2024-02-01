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
  version = "2.0.0"

  name = "example-secondary-cidr-vpc"
  tags = {
    example = "true"
  }
}

# Create the additional CIDR block
module "secondary_cidr" {
  source  = "so1omon563/vpc/aws//modules/additional-cidr-block-association"
  version = "2.0.0"

  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.0.0/16"
}

# Create subnets for Lambda in the new CIDR block
module "lambda_subnets" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "2.0.0"

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
