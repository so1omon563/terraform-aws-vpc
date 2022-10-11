variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "nat_gateway_count" {
  type        = number
  description = "Total number of NAT gateways to create. If set to `-1`, then a NAT gateway will be created per public subnet. If set to `0`, then no NAT gateways will be created. If set to another number, then that number of NAT gateways will be created, in order from the first available public subnet."
  default     = -1
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC the NAT Gateway should be added to."
}
