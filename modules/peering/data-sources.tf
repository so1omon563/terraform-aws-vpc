data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_region" "requester" {
  provider = aws.requester
}

data "aws_region" "accepter" {
  provider = aws.accepter
}

data "aws_caller_identity" "accepter" {
  provider = aws.accepter
}
