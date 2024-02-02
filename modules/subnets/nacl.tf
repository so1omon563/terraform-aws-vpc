resource "aws_network_acl" "nacl" {
  count      = length(aws_subnet.subnet) > 0 ? 1 : 0
  vpc_id     = aws_subnet.subnet[count.index].vpc_id
  subnet_ids = aws_subnet.subnet[*].id
  tags = merge(local.tags,
    {
      Name    = var.subnet_name_overrides != null && var.nacl_name_override != null ? var.nacl_name_override : format("%s-%s-acl", local.name, var.subnet_type)
      network = var.map_public_ip_on_launch == true ? "public" : "private"
    }
  )
}
