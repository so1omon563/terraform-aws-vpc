# Calls the subnets module to create subnets.

module "public_subnets" {
  source = "./modules/subnets"
  vpc_id = aws_vpc.vpc.id

  ipv4_cidr_blocks = var.public_cidrs
  ipv6_cidr_blocks = local.pub_ipv6

  subnet_type = "public"

  map_public_ip_on_launch = true
  restrict_nacls          = var.restrict_nacls

  name = var.name

  tags = local.tags
}

module "private_subnets" {
  source = "./modules/subnets"
  vpc_id = aws_vpc.vpc.id

  ipv4_cidr_blocks = var.private_cidrs
  ipv6_cidr_blocks = local.pvt_ipv6

  subnet_type = "private"

  isolate_route_tables = true
  restrict_nacls       = var.restrict_nacls

  name = var.name

  tags = local.tags

}
