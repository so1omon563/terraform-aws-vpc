resource "aws_network_acl_rule" "ipv4_ingress" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count          = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id = aws_network_acl.nacl[count.index].id
  egress         = false
  protocol       = -1
  #tfsec:ignore:aws-vpc-no-public-ingress-acl - This needs to be able to be configured with open ingress if desired.
  cidr_block  = local.all_ipv4
  rule_action = "allow"
  rule_number = local.max_rule_number
}

resource "aws_network_acl_rule" "ipv6_ingress" {
  #checkov:skip=CKV_AWS_229:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 21" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_230:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 20" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_231:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_232:"Ensure no NACL allow ingress from 0.0.0.0:0 to port 22" - Since this is a re-usable module, this needs to be able to be overridden.

  count          = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id = aws_network_acl.nacl[count.index].id
  egress         = false
  protocol       = -1
  #tfsec:ignore:aws-vpc-no-public-ingress-acl - This needs to be able to be configured with open ingress if desired.
  ipv6_cidr_block = local.all_ipv6
  rule_action     = "allow"
  rule_number     = aws_network_acl_rule.ipv4_ingress[count.index].rule_number - 1
}

resource "aws_network_acl_rule" "ipv4_egress" {
  count          = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id = aws_network_acl.nacl[count.index].id
  egress         = true
  protocol       = -1
  #tfsec:ignore:aws-vpc-no-public-egress-acl - This needs to be able to be configured with open egress if desired.
  cidr_block  = local.all_ipv4
  rule_action = "allow"
  rule_number = local.max_rule_number
}

resource "aws_network_acl_rule" "ipv6_egress" {
  count          = length(aws_subnet.subnet) < 1 || var.restrict_nacls ? 0 : 1
  network_acl_id = aws_network_acl.nacl[count.index].id
  egress         = true
  protocol       = -1
  #tfsec:ignore:aws-vpc-no-public-egress-acl - This needs to be able to be configured with open egress if desired.
  ipv6_cidr_block = local.all_ipv6
  rule_action     = "allow"
  rule_number     = aws_network_acl_rule.ipv4_ingress[count.index].rule_number - 1
}
