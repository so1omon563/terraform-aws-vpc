locals {
  ingress_rule_numbers = setunion(
    aws_network_acl_rule.ingress-ipv4-tcp[*].rule_number,
    aws_network_acl_rule.ingress-ipv4-udp[*].rule_number,
    aws_network_acl_rule.ingress-ipv6-tcp[*].rule_number,
    aws_network_acl_rule.ingress-ipv6-udp[*].rule_number
  )

  egress_rule_numbers = setunion(
    aws_network_acl_rule.egress-ipv4-tcp[*].rule_number,
    aws_network_acl_rule.egress-ipv4-udp[*].rule_number,
    aws_network_acl_rule.egress-ipv6-tcp[*].rule_number,
    aws_network_acl_rule.egress-ipv6-udp[*].rule_number
  )
}
