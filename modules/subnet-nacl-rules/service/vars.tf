
# Since the actual IPv6 cidr block is calculated, and not known during "plan" time, we can't use it in any count
# attributes to handle conditional creation of NACL rules.  We'll use this variable as a way to trigger creation
# of NACL rules for IPv6 enabled subnets
variable "enable_ipv6" {
  type        = bool
  description = "Toggle to create NACL rules for the value specified in ipv6_cidr_block"
  default     = false
}

variable "ipv4_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block to configure in IPv4-specific NACL rules, typically the VPC IPv4 value"
}

variable "ipv6_cidr_block" {
  type        = string
  description = "The IPv6 CIDR block to configure in IPv6-specific NACL rules, typically the VPC IPv6 value, if assigned"
  default     = null
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

variable "nacl_id" {
  type        = string
  description = "The network ACL ID to create rules in"
}
