resource "aws_vpc_peering_connection" "pcx" {
  provider      = aws.requester
  auto_accept   = false
  peer_owner_id = data.aws_caller_identity.accepter.account_id
  peer_region   = data.aws_region.accepter.name
  peer_vpc_id   = var.accepter_vpc_id
  vpc_id        = var.requester_vpc_id
  tags          = merge(local.tags, { Name = format("%s", var.name) })
}

resource "aws_vpc_peering_connection_accepter" "acp" {
  provider    = aws.accepter
  auto_accept = var.auto_accept
  tags        = aws_vpc_peering_connection.pcx.tags

  vpc_peering_connection_id = aws_vpc_peering_connection.pcx.id
}

resource "aws_vpc_peering_connection_options" "requester" {
  count    = data.aws_region.requester.name == data.aws_region.accepter.name && var.auto_accept ? 1 : 0
  provider = aws.requester

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.acp.vpc_peering_connection_id

  requester {
    allow_remote_vpc_dns_resolution = var.allow_remote_dns
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  count    = data.aws_region.requester.name == data.aws_region.accepter.name && var.auto_accept ? 1 : 0
  provider = aws.accepter

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.acp.vpc_peering_connection_id

  requester {
    allow_remote_vpc_dns_resolution = var.allow_remote_dns
  }
}
