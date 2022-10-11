module "cache-network" {
  source = "../../modules/subnets"
  vpc_id = module.vpc.vpc_id

  subnet_type = "elasticache"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr, 6, 6), 2, 2, 2)

  subnets = {
    restrict_nacls = local.restrict_nacls
  }
}

module "redis-nacl" {
  source      = "../../modules/subnet-nacl-rules/service"
  nacl_id     = module.cache-network.nacl["id"]
  enable_ipv6 = local.enable_ipv6

  ipv4_cidr_block   = local.cidr
  ipv6_cidr_block   = module.vpc.vpc["ipv6_cidr_block"]
  ingress_tcp_ports = [6379]
}
