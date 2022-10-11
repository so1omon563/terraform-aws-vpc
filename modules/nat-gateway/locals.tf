locals {
  region                   = data.aws_region.current.id
  account_id               = data.aws_caller_identity.current.account_id
  tags                     = var.tags
  public_subnet_ids        = [for e in data.aws_subnet.public : e.id]
  private_subnet_ids       = [for e in data.aws_subnet.private : e.id]
  private_route_tables_ids = [for e in data.aws_route_table.private : e.id]
  az_short_id              = formatlist("%s", [for i in data.aws_availability_zones.az.names : substr(i, -2, 2)])
  create_natgw             = length(local.public_subnet_ids) > 0
  _natgw_count             = var.nat_gateway_count > 0 ? min(var.nat_gateway_count, length(local.public_subnet_ids)) : length(local.public_subnet_ids)
  natgw_count              = local.create_natgw ? local._natgw_count : 0
  all_ipv4                 = "0.0.0.0/0"
  all_ipv6                 = "::/0"
}
