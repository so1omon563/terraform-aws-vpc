output "cidr_block_association" {
  description = "A collection of outputs from the created CIDR Block Association."
  value       = { for key, value in aws_vpc_ipv4_cidr_block_association.cidr : key => value }
}
