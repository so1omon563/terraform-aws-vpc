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

  vpc = {
    assign_generated_ipv6_cidr_block = true
  }

  name = "example-standard-ipv6-vpc"
  tags = {
    example = "true"
  }
}

module "endpoints" {
  source = "../../modules/gateway-endpoints/by-route-table"
  name   = module.vpc.name_prefix
  tags   = module.vpc.tags

  s3_route_table_ids       = module.vpc.private_route_table_ids[*]
  dynamodb_route_table_ids = module.vpc.private_route_table_ids[*]
}

output "network" {
  value = module.vpc
}
