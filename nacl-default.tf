# Adopt VPC's default NACL into TF, which removes all rules except the default "DENY" rules
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  tags                   = merge(local.tags, { Name = format("%s-default", var.name) })
}
