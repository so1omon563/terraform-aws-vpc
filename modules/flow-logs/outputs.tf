output "log_group" {
  description = "A collection of outputs from the created Flow Logs Log Group."
  value = {
    id   = aws_cloudwatch_log_group.flow-logs.id
    arn  = aws_cloudwatch_log_group.flow-logs.arn
    name = aws_cloudwatch_log_group.flow-logs.name
  }
}
