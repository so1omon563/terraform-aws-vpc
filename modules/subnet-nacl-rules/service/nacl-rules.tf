# Ingress rules for the specified TCP and/or UDP ports to the provided IPv4 and IPv6 cidr blocks
resource "aws_network_acl_rule" "ingress-ipv4-tcp" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count          = length(var.ingress_tcp_ports)
  network_acl_id = var.nacl_id
  egress         = false
  rule_number    = 31000 + count.index
  rule_action    = "allow"
  protocol       = 6
  cidr_block     = var.ipv4_cidr_block
  from_port      = var.ingress_tcp_ports[count.index]
  to_port        = var.ingress_tcp_ports[count.index]
}

resource "aws_network_acl_rule" "ingress-ipv6-tcp" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count           = var.enable_ipv6 ? length(var.ingress_tcp_ports) : 0
  network_acl_id  = aws_network_acl_rule.ingress-ipv4-tcp[count.index].network_acl_id
  egress          = aws_network_acl_rule.ingress-ipv4-tcp[count.index].egress
  rule_number     = aws_network_acl_rule.ingress-ipv4-tcp[count.index].rule_number + 500
  rule_action     = aws_network_acl_rule.ingress-ipv4-tcp[count.index].rule_action
  protocol        = aws_network_acl_rule.ingress-ipv4-tcp[count.index].protocol
  ipv6_cidr_block = var.ipv6_cidr_block
  from_port       = aws_network_acl_rule.ingress-ipv4-tcp[count.index].from_port
  to_port         = aws_network_acl_rule.ingress-ipv4-tcp[count.index].to_port
}

resource "aws_network_acl_rule" "ingress-ipv4-udp" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count          = length(var.ingress_udp_ports)
  network_acl_id = var.nacl_id
  egress         = false
  rule_number    = 32000 + count.index
  rule_action    = "allow"
  protocol       = 17
  cidr_block     = var.ipv4_cidr_block
  from_port      = var.ingress_udp_ports[count.index]
  to_port        = var.ingress_udp_ports[count.index]
}

resource "aws_network_acl_rule" "ingress-ipv6-udp" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count           = var.enable_ipv6 ? length(var.ingress_udp_ports) : 0
  network_acl_id  = aws_network_acl_rule.ingress-ipv4-udp[count.index].network_acl_id
  egress          = aws_network_acl_rule.ingress-ipv4-udp[count.index].egress
  rule_number     = aws_network_acl_rule.ingress-ipv4-udp[count.index].rule_number + 500
  rule_action     = aws_network_acl_rule.ingress-ipv4-udp[count.index].rule_action
  protocol        = aws_network_acl_rule.ingress-ipv4-udp[count.index].protocol
  ipv6_cidr_block = var.ipv6_cidr_block
  from_port       = aws_network_acl_rule.ingress-ipv4-udp[count.index].from_port
  to_port         = aws_network_acl_rule.ingress-ipv4-udp[count.index].to_port
}

# Reciprocal egress TCP and UDP rules to allow return traffic over ephemeral ports
resource "aws_network_acl_rule" "egress-ipv4-tcp" {
  count          = length(aws_network_acl_rule.ingress-ipv4-tcp) > 0 ? 1 : 0
  network_acl_id = aws_network_acl_rule.ingress-ipv4-tcp[count.index].network_acl_id
  egress         = true
  rule_number    = 31000 + count.index
  rule_action    = aws_network_acl_rule.ingress-ipv4-tcp[count.index].rule_action
  protocol       = aws_network_acl_rule.ingress-ipv4-tcp[count.index].protocol
  cidr_block     = aws_network_acl_rule.ingress-ipv4-tcp[count.index].cidr_block
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "egress-ipv6-tcp" {
  count           = length(aws_network_acl_rule.ingress-ipv6-tcp) > 0 ? 1 : 0
  network_acl_id  = aws_network_acl_rule.ingress-ipv6-tcp[count.index].network_acl_id
  egress          = true
  rule_number     = 31500 + count.index
  rule_action     = aws_network_acl_rule.ingress-ipv6-tcp[count.index].rule_action
  protocol        = aws_network_acl_rule.ingress-ipv6-tcp[count.index].protocol
  ipv6_cidr_block = aws_network_acl_rule.ingress-ipv6-tcp[count.index].ipv6_cidr_block
  from_port       = 1024
  to_port         = 65535
}

resource "aws_network_acl_rule" "egress-ipv4-udp" {
  count          = length(aws_network_acl_rule.ingress-ipv4-udp) > 0 ? 1 : 0
  network_acl_id = aws_network_acl_rule.ingress-ipv4-udp[count.index].network_acl_id
  egress         = true
  rule_number    = 32000 + count.index
  rule_action    = aws_network_acl_rule.ingress-ipv4-udp[count.index].rule_action
  protocol       = aws_network_acl_rule.ingress-ipv4-udp[count.index].protocol
  cidr_block     = aws_network_acl_rule.ingress-ipv4-udp[count.index].cidr_block
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "egress-ipv6-udp" {
  count           = length(aws_network_acl_rule.ingress-ipv6-udp) > 0 ? 1 : 0
  network_acl_id  = aws_network_acl_rule.ingress-ipv6-udp[count.index].network_acl_id
  egress          = true
  rule_number     = 32500 + count.index
  rule_action     = aws_network_acl_rule.ingress-ipv6-udp[count.index].rule_action
  protocol        = aws_network_acl_rule.ingress-ipv6-udp[count.index].protocol
  ipv6_cidr_block = aws_network_acl_rule.ingress-ipv6-udp[count.index].ipv6_cidr_block
  from_port       = 1024
  to_port         = 65535
}
