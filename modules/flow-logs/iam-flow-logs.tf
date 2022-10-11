resource "aws_iam_role" "flow-logs" {
  count       = local.create_logs
  name        = format("%s-flow-logs", aws_cloudwatch_log_group.flow-logs.name)
  description = "VPC Flow Logs role for Cloudwatch Logs"
  tags        = local.tags

  assume_role_policy = data.aws_iam_policy_document.ar.json
}

resource "aws_iam_role_policy" "flow-logs" {
  count  = local.create_logs
  role   = aws_iam_role.flow-logs[count.index].id
  policy = data.aws_iam_policy_document.logs.json
}
