# Adopt VPC's default Security Group into TF, which removes all rules
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.tags, { Name = format("%s-default", var.name) })
}
