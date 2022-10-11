output "log_group" {
  value = {
    id   = aws_cloudwatch_log_group.flow-logs.id
    arn  = aws_cloudwatch_log_group.flow-logs.arn
    name = aws_cloudwatch_log_group.flow-logs.name
  }
}
