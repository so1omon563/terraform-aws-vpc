
resource "aws_eip" "eip" {
  count  = local.natgw_count
  domain = "vpc"
  tags   = merge(local.tags, { Name = format("%s-nat", var.name) })

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "natgw" {
  count         = local.natgw_count
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = element(module.public_subnets.subnets, count.index).id
  tags = merge(aws_eip.eip[count.index].tags,
    {
      Name              = format("%s-ngw-%s", var.name, element(local.short_az_id, count.index))
      availability_zone = element(module.public_subnets.subnets, count.index).availability_zone
    }
  )
}
