variable "nacl_id" {
  description = "The network ACL ID to create rules in"
}

# Since the actual IPv6 cidr block is calculated, and not known during "plan" time, we can't use it in any count
# attributes to handle conditional creation of NACL rules.  We'll use this variable as a way to trigger creation
# of NACL rules for IPv6 enabled subnets
variable "enable_ipv6" {
  type        = bool
  description = "Toggle to create NACL rules for the value specified in ipv6_cidr_block"
  default     = false
}

variable "ipv6_cidr" {
  type        = string
  description = "The IPv6 CIDR block to configure in IPv6-specific NACL rules, typically the VPC IPv6 value, if assigned"
  default     = null
}

variable "extra_ipv4_cidr" {
  type        = list(string)
  description = <<EOT
  List of additional CIDR blocks to grant full access NACL rules.
  Combined with values in `local.extra_ipv4_cidr_defaults` - `["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]`
  EOT
  default     = []
}

variable "ingress_tcp_ports" {
  type        = list(number)
  description = "List of TCP port numbers for creating ingress NACL rules"
  default     = []
}

variable "ingress_udp_ports" {
  type        = list(number)
  description = "List of UDP port numbers for creating ingress NACL rules"
  default     = []
}

variable "egress_tcp_ports" {
  type        = list(number)
  description = "List of additional TCP port numbers for creating egress NACL rules, combined with values in `local.egress_udp_ports_defaults` - `[80, 443]`"
  default     = []
}

variable "egress_udp_ports" {
  type        = list(number)
  description = "List of additional UDP port numbers for creating egress NACL rules, combined with values in `local.egress_udp_ports_defaults` - `[123]`"
  default     = []
}
