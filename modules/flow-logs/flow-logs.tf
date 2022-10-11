resource "aws_cloudwatch_log_group" "flow-logs" {
  name = var.vpc_id
  tags = local.tags

  retention_in_days = var.retention_days
  kms_key_id        = var.kms_key_id
}

resource "aws_flow_log" "logs" {
  count        = local.create_logs
  traffic_type = "ALL"
  iam_role_arn = aws_iam_role.flow-logs[count.index].arn
  vpc_id       = var.vpc_id
  tags         = local.tags

  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.flow-logs.arn
}
