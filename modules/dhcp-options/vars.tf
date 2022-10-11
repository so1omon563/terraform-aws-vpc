variable "domain_name" {
  type        = string
  description = "The suffix domain name to use by default when resolving non Fully Qualified Domain Names"
  default     = null
}

variable "domain_name_servers" {
  type        = list(string)
  description = "List of DNS servers. Default is 'AmazonProvidedDNS'"
  default     = ["AmazonProvidedDNS"]
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "netbios_name_servers" {
  type        = list(string)
  description = "List of NETBIOS name servers"
  default     = null
}

variable "ntp_servers" {
  type        = list(string)
  description = "List of NTP servers"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "vpc_id" {
  description = "The VPC ID for the DHCP options"
}
