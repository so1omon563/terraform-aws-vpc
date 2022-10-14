module "cache-network" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "1.0.0"

  vpc_id = module.vpc.vpc_id

  subnet_type = "elasticache"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr_block, 6, 6), 2, 2, 2)

  restrict_nacls = local.restrict_nacls
}

module "redis-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/service"
  version = "1.0.0"

  nacl_id = module.cache-network.nacl.id

  ipv4_cidr_block   = local.cidr_block
  ingress_tcp_ports = [6379]
}
