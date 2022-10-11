module "vpc" {
  source = "../../"

  name = "example-standard-vpc"
  tags = {
    t_dcl         = "1"
    t_environment = "DEV"
    t_AppID       = "SVC00000"
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

output "endpoints" {
  value = module.endpoints
}
