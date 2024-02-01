resource "aws_eip" "eip" {
  count  = local.natgw_count
  domain = "vpc"
  tags = merge(local.tags,
    {
      Name = format("%s-nat", var.name)
    }
  )
}

resource "aws_nat_gateway" "natgw" {
  count         = local.natgw_count
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = element(local.public_subnet_ids, count.index)
  tags = merge(aws_eip.eip[count.index].tags,
    {
      Name = format("%s-ngw-%s", var.name, element(local.az_short_id, count.index))
    }
  )
}
