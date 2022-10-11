locals {
  // list of attributes to filter from output variables because they're sensitive, or useless
  output_filter = ["assume_role_policy", "description", "egress", "ingress", "policy", "tags"]
}

output "nat_gateways" {
  value = [for nat in aws_nat_gateway.natgw : { for key, value in nat : key => value if !contains(local.output_filter, key) }]
}
