locals {
  // list of attributes to expose as output variable properties
  output_filter = [
    "id", "arn", "availability_zone", "assign_ipv6_address_on_creation", "map_public_ip_on_launch", "subnet_ids"
  ]
}

output "subnets" {
  value = [for subnet in aws_subnet.subnet : { for key, value in subnet : key => value if contains(local.output_filter, key) }]
}

output "route_table_ids" {
  value = aws_route_table.route_table[*].id
}

output "nacl" {
  value = length(aws_network_acl.nacl) > 0 ? { for key, value in aws_network_acl.nacl[0] : key => value if contains(local.output_filter, key) } : null
}
