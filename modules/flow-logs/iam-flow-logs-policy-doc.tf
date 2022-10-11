data "aws_iam_policy_document" "ar" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "logs" {
  #checkov:skip=CKV_AWS_111:"Ensure IAM policies does not allow write access without constraints" - This wildcard is intentional.
  statement {
    actions   = ["logs:CreateLogGroup"]
    resources = ["*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    #tfsec:ignore:aws-iam-no-policy-wildcards - This wildcard is intentional.
    resources = [
      aws_cloudwatch_log_group.flow-logs.arn,
      format("%s:log-stream:*", aws_cloudwatch_log_group.flow-logs.arn)
    ]
  }
}
