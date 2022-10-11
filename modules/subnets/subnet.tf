# See https://github.com/terraform-providers/terraform-provider-aws/issues/10815
# For reason why we can't remove an ipv6_cidr_block after assignment
resource "aws_subnet" "subnet" {
  count             = local.subnet_count
  vpc_id            = var.vpc_id
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  cidr_block        = var.ipv4_cidr_blocks[count.index]
  ipv6_cidr_block   = length(var.ipv6_cidr_blocks) > 0 ? var.ipv6_cidr_blocks[count.index] : null
  tags = merge(local.tags,
    {
      Name              = format("%s-%s-%s", var.name, var.subnet_type, element(local.az_short_id, count.index))
      network           = var.map_public_ip_on_launch == true ? "public" : "private"
      availability_zone = element(data.aws_availability_zones.az.names, count.index)
    }
  )

  assign_ipv6_address_on_creation = length(var.ipv6_cidr_blocks) > 0
  map_public_ip_on_launch         = var.map_public_ip_on_launch
}
