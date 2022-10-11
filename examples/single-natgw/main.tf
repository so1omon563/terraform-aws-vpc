module "vpc" {
  source = "../../"

  vpc = {
    nat_gateway_count = 1
  }

  name = "example-single-natgw-vpc"
  tags = {
    t_dcl         = "1"
    t_environment = "DEV"
    t_AppID       = "SVC00000"
  }
}

output "network" {
  value = module.vpc
}
