locals {
  region                    = data.aws_region.current.id
  account_id                = data.aws_caller_identity.current.account_id
  all_ipv4                  = "0.0.0.0/0"
  all_ipv6                  = "::/0"
  extra_ipv4_cidr_defaults  = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  ipv4_cidrs                = distinct(concat(local.extra_ipv4_cidr_defaults, var.extra_ipv4_cidr))
  max_rule_number           = 32766 # Per AWS docs (https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#nacl-basics)
  egress_tcp_ports_defaults = [80, 443]
  egress_udp_ports_defaults = [123]
  egress_tcp_whitelist      = distinct(concat(local.egress_tcp_ports_defaults, var.egress_tcp_ports))
  egress_udp_whitelist      = distinct(concat(local.egress_udp_ports_defaults, var.egress_udp_ports))
}
