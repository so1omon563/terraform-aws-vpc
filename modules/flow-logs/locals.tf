locals {
  tags        = var.tags
  create_logs = var.create_flow_logs ? 1 : 0
}
