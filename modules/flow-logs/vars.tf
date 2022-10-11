variable "create_flow_logs" {
  type        = bool
  description = "Whether or not to create flow logs for the VPC."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  default     = null
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "retention_days" {
  type        = number
  description = "The number of days to retain flow log records."
  default     = 365
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "vpc_id" {
  description = "The VPC ID for the flow logs"
}
