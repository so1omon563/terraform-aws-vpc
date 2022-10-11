locals {
  cidr           = "10.20.32.0/20"
  enable_ipv6    = false
  restrict_nacls = true
}

module "vpc" {
  source = "../.."

  vpc = {
    cidr              = local.cidr
    enable_ipv6       = local.enable_ipv6
    restrict_nacls    = local.restrict_nacls
    nat_gateway_count = 1
  }

  public_cidrs  = cidrsubnets(local.cidr, 6, 6, 6)
  private_cidrs = cidrsubnets(cidrsubnet(local.cidr, 1, 1), 2, 2, 2)

  name = "example-extra-security-vpc"

  tags = {
    t_dcl         = "1"
    t_environment = "DEV"
    t_AppID       = "SVC00000"
  }
}

output "network" {
  value = module.vpc
}
