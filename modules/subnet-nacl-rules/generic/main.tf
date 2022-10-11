/**
* Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
*/
terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38"
    }
  }
}


# Configure the "base" NACL rules to allow whitelisted TCP and UDP ingress ports from anywhere
module "base" {
  source            = "../service-subnet-nacl-rules"
  nacl_id           = var.nacl_id
  ipv4_cidr_block   = local.all_ipv4
  ipv6_cidr_block   = local.all_ipv6
  enable_ipv6       = var.enable_ipv6
  ingress_tcp_ports = var.ingress_tcp_ports
  ingress_udp_ports = var.ingress_udp_ports
}

# A generic subnet NACL is a superset of the service-specific subnet NACLs, suitable for use in generic/general-purpose
# public or private subnets.
