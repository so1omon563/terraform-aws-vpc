variable "dynamodb_policy" {
  description = "Optional IAM policy to attach to the endpoint that controls access to DynamoDB"
  default     = null
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "s3_policy" {
  description = "Optional IAM policy to attach to the endpoint that controls access to S3"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC the endpoints should be added to."
}
