output "cidr_block_association" {
  value = { for key, value in aws_vpc_ipv4_cidr_block_association.cidr : key => value }
}
