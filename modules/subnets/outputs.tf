locals {
  // list of attributes to expose as output variable properties
  output_filter = [
    "id", "arn", "availability_zone", "assign_ipv6_address_on_creation", "map_public_ip_on_launch", "subnet_ids", "tags"
  ]
}

output "subnets" {
  description = "A collection of outputs from the created Subnets."
  value       = [for subnet in aws_subnet.subnet : { for key, value in subnet : key => value if contains(local.output_filter, key) }]
}

output "route_table_ids" {
  description = "A list of the route table ids created by this module."
  value       = aws_route_table.route_table[*].id
}

output "nacl" {
  description = "A collection of outputs from the NACL created by this module."
  value       = length(aws_network_acl.nacl) > 0 ? { for key, value in aws_network_acl.nacl[0] : key => value if contains(local.output_filter, key) } : null
}
