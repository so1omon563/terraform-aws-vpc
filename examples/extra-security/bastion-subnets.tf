module "bastion-network" {
  source = "../../modules//subnets"
  vpc_id = module.vpc.vpc_id

  subnet_type = "bastion"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr_block, 7, 8), 1, 1)


  map_public_ip_on_launch = true
  restrict_nacls          = local.restrict_nacls
}

output "bastion-network" {
  value = module.bastion-network
}

resource "aws_route" "ipv4_default" {
  count          = length(module.bastion-network.route_table_ids)
  route_table_id = module.bastion-network.route_table_ids[count.index]
  gateway_id     = module.vpc.vpc["igw_id"]

  destination_cidr_block = "0.0.0.0/0"
}

# This opens port 22 from anywhere, so be sure to use your security group to narrow the scope
module "bastion-nacl" {
  source  = "../../modules/subnet-nacl-rules/generic"
  nacl_id = module.bastion-network.nacl.id

  ingress_tcp_ports = [22]
}
