variable "accepter_vpc_id" {
  type        = string
  description = "The ID of the accepter VPC"
}

variable "allow_remote_dns" {
  type        = bool
  description = "Allow resolution of public DNS hostnames to private IP addresses across the peering connection"
  default     = false
}

variable "auto_accept" {
  type        = bool
  description = "Automatically accept the VPC peering connection request"
  default     = false
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "requester_vpc_id" {
  type        = string
  description = "The ID of the requester VPC"
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}
