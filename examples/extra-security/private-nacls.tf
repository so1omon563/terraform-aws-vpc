module "private-nacl" {
  source      = "../../modules/generic-subnet-nacl-rules"
  nacl_id     = module.vpc.private_nacl["id"]
  enable_ipv6 = local.enable_ipv6
  ipv6_cidr   = module.vpc.vpc["ipv6_cidr_block"]
}
