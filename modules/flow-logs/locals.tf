locals {
  region      = data.aws_region.current.id
  account_id  = data.aws_caller_identity.current.account_id
  tags        = var.tags
  create_logs = var.create_flow_logs ? 1 : 0
}
