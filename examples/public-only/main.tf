module "vpc" {
  source = "../../"

  private_cidrs = []

  name = "example-public-only-vpc"
  tags = {
    t_dcl         = "1"
    t_environment = "DEV"
    t_AppID       = "SVC00000"
  }
}

output "network" {
  value = module.vpc
}
