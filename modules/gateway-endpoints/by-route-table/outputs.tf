locals {
  // list of attributes to expose as output variable properties
  output_filter = ["id", "arn", "prefix_list_id"]
}

output "dynamodb" {
  description = "A collection of outputs from the created DynamoDB Gateway Endpoint."
  value = {
    for key, value in aws_vpc_endpoint.dynamodb : key => value if contains(local.output_filter, key)
  }
}

output "s3" {
  description = "A collection of outputs from the created S3 Gateway Endpoint."
  value = {
    for key, value in aws_vpc_endpoint.s3 : key => value if contains(local.output_filter, key)
  }
}
