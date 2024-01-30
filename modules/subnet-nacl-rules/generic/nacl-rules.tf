# Allow all whitelisted TCP and UDP egress ports out to any IPv4 and IPv6 destination
resource "aws_network_acl_rule" "ipv4-tcp-egress" {
  count          = length(local.egress_tcp_whitelist)
  network_acl_id = var.nacl_id
  egress         = true
  rule_number    = 29000 + count.index
  rule_action    = "allow"
  protocol       = 6
  cidr_block = local.all_ipv4
  from_port  = local.egress_tcp_whitelist[count.index]
  to_port    = local.egress_tcp_whitelist[count.index]
}

resource "aws_network_acl_rule" "ipv6-tcp-egress" {

  count          = var.enable_ipv6 ? length(local.egress_tcp_whitelist) : 0
  network_acl_id = aws_network_acl_rule.ipv4-tcp-egress[count.index].network_acl_id
  egress         = aws_network_acl_rule.ipv4-tcp-egress[count.index].egress
  rule_number    = aws_network_acl_rule.ipv4-tcp-egress[count.index].rule_number + 500
  rule_action    = aws_network_acl_rule.ipv4-tcp-egress[count.index].rule_action
  protocol       = aws_network_acl_rule.ipv4-tcp-egress[count.index].protocol
  ipv6_cidr_block = local.all_ipv6
  from_port       = aws_network_acl_rule.ipv4-tcp-egress[count.index].from_port
  to_port         = aws_network_acl_rule.ipv4-tcp-egress[count.index].to_port
}

resource "aws_network_acl_rule" "ipv4-udp-egress" {
  count          = length(local.egress_udp_whitelist)
  network_acl_id = var.nacl_id
  egress         = true
  rule_number    = 30000 + count.index
  rule_action    = "allow"
  protocol       = 17
  cidr_block = local.all_ipv4
  from_port  = local.egress_udp_whitelist[count.index]
  to_port    = local.egress_udp_whitelist[count.index]
}

resource "aws_network_acl_rule" "ipv6-udp-egress" {
  count          = var.enable_ipv6 ? length(local.egress_udp_whitelist) : 0
  network_acl_id = aws_network_acl_rule.ipv4-udp-egress[count.index].network_acl_id
  egress         = aws_network_acl_rule.ipv4-udp-egress[count.index].egress
  rule_number    = aws_network_acl_rule.ipv4-udp-egress[count.index].rule_number + 500
  rule_action    = aws_network_acl_rule.ipv4-udp-egress[count.index].rule_action
  protocol       = aws_network_acl_rule.ipv4-udp-egress[count.index].protocol
  ipv6_cidr_block = local.all_ipv6
  from_port       = aws_network_acl_rule.ipv4-udp-egress[count.index].from_port
  to_port         = aws_network_acl_rule.ipv4-udp-egress[count.index].to_port
}

# Allow all traffic within the RFC 1918 and VPC IPv6 CIDR blocks
# Making these extra-generic allows us to avoid all sorts of icky-ness when dealing with secondary VPC CIDR allocations,
# VPC peering, Direct Connect, or Site-to-Site VPN connections
resource "aws_network_acl_rule" "vpc-ipv4-ingress" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count          = length(local.ipv4_cidrs)
  network_acl_id = var.nacl_id
  egress         = false
  rule_number    = local.max_rule_number - length(local.ipv4_cidrs) + count.index
  rule_action    = "allow"
  protocol       = -1
  cidr_block     = local.ipv4_cidrs[count.index]
}

resource "aws_network_acl_rule" "vpc-ipv6-ingress" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.
  count           = var.enable_ipv6 ? 1 : 0
  network_acl_id  = aws_network_acl_rule.vpc-ipv4-ingress[count.index].network_acl_id
  egress          = aws_network_acl_rule.vpc-ipv4-ingress[count.index].egress
  rule_number     = local.max_rule_number
  rule_action     = aws_network_acl_rule.vpc-ipv4-ingress[count.index].rule_action
  protocol        = aws_network_acl_rule.vpc-ipv4-ingress[count.index].protocol
  ipv6_cidr_block = var.ipv6_cidr
}

resource "aws_network_acl_rule" "vpc-ipv4-egress" {
  count          = length(local.ipv4_cidrs)
  network_acl_id = aws_network_acl_rule.vpc-ipv4-ingress[count.index].network_acl_id
  egress         = true
  rule_number    = local.max_rule_number - length(local.ipv4_cidrs) + count.index
  rule_action    = "allow"
  protocol       = -1
  cidr_block     = local.ipv4_cidrs[count.index]
}

resource "aws_network_acl_rule" "vpc-ipv6-egress" {
  count           = var.enable_ipv6 ? 1 : 0
  network_acl_id  = aws_network_acl_rule.vpc-ipv4-egress[count.index].network_acl_id
  egress          = aws_network_acl_rule.vpc-ipv4-egress[count.index].egress
  rule_number     = local.max_rule_number
  rule_action     = aws_network_acl_rule.vpc-ipv4-egress[count.index].rule_action
  protocol        = aws_network_acl_rule.vpc-ipv4-egress[count.index].protocol
  ipv6_cidr_block = var.ipv6_cidr
}

# if custom egress ports exist, create a reciprocal ephemeral ingress rule to allow return traffic
resource "aws_network_acl_rule" "ipv4-tcp-ingress-ephemeral" {
  count          = length(aws_network_acl_rule.ipv4-tcp-egress) > 0 ? 1 : 0
  network_acl_id = aws_network_acl_rule.ipv4-tcp-egress[count.index].network_acl_id
  egress         = false
  rule_number    = aws_network_acl_rule.ipv4-tcp-egress[count.index].rule_number + 250
  rule_action    = aws_network_acl_rule.ipv4-tcp-egress[count.index].rule_action
  protocol       = aws_network_acl_rule.ipv4-tcp-egress[count.index].protocol
  cidr_block = aws_network_acl_rule.ipv4-tcp-egress[count.index].cidr_block
  from_port  = 1024
  to_port    = 65535
}

resource "aws_network_acl_rule" "ipv6-tcp-ingress-ephemeral" {
  count          = length(aws_network_acl_rule.ipv6-tcp-egress) > 0 ? 1 : 0
  network_acl_id = aws_network_acl_rule.ipv6-tcp-egress[count.index].network_acl_id
  egress         = false
  rule_number    = aws_network_acl_rule.ipv6-tcp-egress[count.index].rule_number + 250
  rule_action    = aws_network_acl_rule.ipv6-tcp-egress[count.index].rule_action
  protocol       = aws_network_acl_rule.ipv6-tcp-egress[count.index].protocol
  ipv6_cidr_block = aws_network_acl_rule.ipv6-udp-egress[count.index].ipv6_cidr_block
  from_port       = 1024
  to_port         = 65535
}

resource "aws_network_acl_rule" "ipv4-udp-ingress-ephemeral" {
  count          = length(aws_network_acl_rule.ipv4-udp-egress) > 0 ? 1 : 0
  network_acl_id = aws_network_acl_rule.ipv4-udp-egress[count.index].network_acl_id
  egress         = false
  rule_number    = aws_network_acl_rule.ipv4-udp-egress[count.index].rule_number + 250
  rule_action    = aws_network_acl_rule.ipv4-udp-egress[count.index].rule_action
  protocol       = aws_network_acl_rule.ipv4-udp-egress[count.index].protocol
  cidr_block = aws_network_acl_rule.ipv4-udp-egress[count.index].cidr_block
  from_port  = 1024
  to_port    = 65535
}

resource "aws_network_acl_rule" "ipv6-udp-ingress-ephemeral" {
  count          = length(aws_network_acl_rule.ipv6-udp-egress) > 0 ? 1 : 0
  network_acl_id = aws_network_acl_rule.ipv6-udp-egress[count.index].network_acl_id
  egress         = false
  rule_number    = aws_network_acl_rule.ipv6-udp-egress[count.index].rule_number + 250
  rule_action    = aws_network_acl_rule.ipv6-udp-egress[count.index].rule_action
  protocol       = aws_network_acl_rule.ipv6-udp-egress[count.index].protocol
  ipv6_cidr_block = aws_network_acl_rule.ipv6-udp-egress[count.index].ipv6_cidr_block
  from_port       = 1024
  to_port         = 65535
}
