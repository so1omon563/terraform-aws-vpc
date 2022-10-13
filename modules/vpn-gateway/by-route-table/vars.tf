variable "amazon_side_asn" {
  type        = number
  description = "The Autonomous System Number for the AWS side of the gateway."
  default     = null
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of route table IDs to propagate VPN routes into."
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}
