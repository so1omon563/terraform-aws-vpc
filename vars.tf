variable "create_flow_logs" {
  type        = bool
  description = "Whether or not to create flow logs for the VPC. Defaults to `true`, per AWS best practices."
  default     = true
}

variable "flow_logs_kms_key_id" {
  type        = string
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  default     = null
}

variable "log_retention_days" {
  type        = number
  description = "The number of days to retain flow log records."
  default     = 365
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "nat_gateway_count" {
  type        = number
  description = "Total number of NAT gateways to create. If set to `-1`, then a NAT gateway will be created per public subnet. If set to `0`, then no NAT gateways will be created. If set to another number, then that number of NAT gateways will be created, in order from the first available public subnet."
  default     = -1
}

variable "public_cidrs" {
  type        = list(string)
  description = "List of IPv4 CIDR blocks used for public subnets"
  default     = ["10.255.255.192/28", "10.255.255.208/28"]
}

variable "private_cidrs" {
  type        = list(string)
  description = "List of IPv4 CIDR blocks used for private subnets"
  default     = ["10.255.255.224/28", "10.255.255.240/28"]
}

variable "restrict_nacls" {
  type        = bool
  description = "If this is set to `true`, network ACL resource created for these subnets will be left empty and deny all ingress and egress traffic. This is useful if you want to manage NACLs outside of this module. If set to `false`, `allow all` ingress and egress NACL rules are created for the subnets"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "vpc" {
  type        = map(string)
  description = <<EOT
  A map of VPC properties. Options in `local.vpc_defaults` can be overridden here.
  Default values are:
```
  vpc_defaults = {
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "10.255.255.192/26"
    enable_dns_support               = true
    enable_dns_hostnames             = true
    instance_tenancy                 = "default"
  }
```
  See [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) for more information on the options
  EOT
  default     = {}
}
