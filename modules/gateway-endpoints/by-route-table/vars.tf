variable "dynamodb_policy" {
  description = "Optional IAM policy to attach to the endpoint that controls access to DynamoDB"
  default     = null
}

variable "dynamodb_route_table_ids" {
  type        = list(string)
  description = "List of route table IDs to associate with the DynamoDB endpoint"
  default     = []
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "s3_policy" {
  description = "Optional IAM policy to attach to the endpoint that controls access to S3"
  default     = null
}

variable "s3_route_table_ids" {
  type        = list(string)
  description = "List of route table IDs to associate with the S3 endpoint"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}
