resource "aws_network_acl_rule" "ipv4_ingress" {
  count          = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id = aws_network_acl.nacl[count.index].id
  egress         = false
  protocol       = -1
  cidr_block     = local.all_ipv4
  rule_action    = "allow"
  rule_number    = local.max_rule_number
}

resource "aws_network_acl_rule" "ipv6_ingress" {
  count           = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id  = aws_network_acl.nacl[count.index].id
  egress          = false
  protocol        = -1
  ipv6_cidr_block = local.all_ipv6
  rule_action     = "allow"
  rule_number     = aws_network_acl_rule.ipv4_ingress[count.index].rule_number - 1
}

resource "aws_network_acl_rule" "ipv4_egress" {
  count          = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id = aws_network_acl.nacl[count.index].id
  egress         = true
  protocol       = -1
  cidr_block     = local.all_ipv4
  rule_action    = "allow"
  rule_number    = local.max_rule_number
}

resource "aws_network_acl_rule" "ipv6_egress" {
  count           = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id  = aws_network_acl.nacl[count.index].id
  egress          = true
  protocol        = -1
  ipv6_cidr_block = local.all_ipv6
  rule_action     = "allow"
  rule_number     = aws_network_acl_rule.ipv4_ingress[count.index].rule_number - 1
}
