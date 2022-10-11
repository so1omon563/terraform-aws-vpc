variable "ipv4_cidr_blocks" {
  type        = list(string)
  description = "List of IPv4 cidr blocks to configure subnets"
}

variable "ipv6_cidr_blocks" {
  type        = list(string)
  description = "List of IPv6 cidr blocks to configure subnets. If specified, length must match ipv4_cidr_blocks"
  default     = []
}

variable "isolate_route_tables" {
  description = "If `true`, a route table will be created for each subnet, otherwise a single route table will be created for all subnets managed by this module"
  type        = bool
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "If true, automatically assign a public IPv4 address to resources in the subnets."
  type        = bool
  default     = false
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID for the subnets"
}

variable "restrict_nacls" {
  type        = bool
  description = "If this is set to `true`, network ACL resource created for these subnets will be left empty and deny all ingress and egress traffic. This is useful if you want to manage NACLs outside of this module. If set to `false`, `allow all` ingress and egress NACL rules are created for the subnets"
  default     = false
}

variable "subnet_type" {
  type        = string
  description = "A value that will be appended to the `var.name` to name the subnet. Will also be used to name the route table if `var.isolate_route_tables` is `true`"
  default     = "subnet"
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}
