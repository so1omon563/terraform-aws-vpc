resource "aws_subnet" "subnet" {
  #checkov:skip=CKV_AWS_130:"Ensure VPC subnets do not assign public IP by default" - Since this is a re-usable module, this needs to be able to be overridden.
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
