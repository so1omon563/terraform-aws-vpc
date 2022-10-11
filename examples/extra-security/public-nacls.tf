module "public-nacl" {
  source      = "../../modules/subnet-nacl-rules/generic"
  nacl_id     = module.vpc.public_nacl["id"]
  enable_ipv6 = local.enable_ipv6
  ipv6_cidr   = module.vpc.vpc["ipv6_cidr_block"]

  ingress_tcp_ports = [80, 443]
}
