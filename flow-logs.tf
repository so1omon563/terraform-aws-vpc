#Calling the flow-logs module to create flow logs.

module "logs" {
  source = "./modules/flow-logs"

  vpc_id = aws_vpc.vpc.id
  name   = var.name
  tags   = local.tags

  create_flow_logs = var.create_flow_logs
  retention_days   = var.log_retention_days
  kms_key_id       = var.flow_logs_kms_key_id


}
