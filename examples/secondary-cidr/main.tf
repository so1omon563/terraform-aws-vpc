module "vpc" {
  source = "../../"

  name = "example-secondary-cidr-vpc"
  tags = {
    t_dcl         = "1"
    t_environment = "DEV"
    t_AppID       = "SVC00000"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "cidr" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.0.0/16"
}

module "lambda_subnets" {
  source      = "../../modules/subnets"
  vpc_id      = aws_vpc_ipv4_cidr_block_association.cidr.vpc_id
  name        = module.vpc.name_prefix
  subnet_type = "lambda"
  tags        = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(aws_vpc_ipv4_cidr_block_association.cidr.cidr_block, 8, 8, 8, 8)
}

output "network" {
  value = module.vpc
}

output "lambda_subnets" {
  value = module.lambda_subnets
}
