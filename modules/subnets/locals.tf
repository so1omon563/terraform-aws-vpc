locals {
  region          = data.aws_region.current.id
  account_id      = data.aws_caller_identity.current.account_id
  tags            = var.tags
  subnet_count    = length(var.ipv4_cidr_blocks)
  az_short_id     = formatlist("%s", [for i in data.aws_availability_zones.az.names : substr(i, -2, 2)])
  all_ipv4        = "0.0.0.0/0"
  all_ipv6        = "::/0"
  max_rule_number = 32766 # Per AWS docs (https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#nacl-basics)
  name            = var.name != null ? var.name : "default-name"
}
