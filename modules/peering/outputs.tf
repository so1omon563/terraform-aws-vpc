locals {
  output_filter = ["id", "accept_status"]
}

output "peering_connection" {
  value = { for key, value in aws_vpc_peering_connection.pcx : key => value if contains(local.output_filter, key) }
}
