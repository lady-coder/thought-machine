resource "aws_security_group" "this" {
  name        = lower("${local.name}-sg")
  vpc_id      = var.vpc_id
  description = "Security group for autoscaling group"
}

resource "aws_security_group_rule" "egress" {
  for_each = var.security_group_rules_egress

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = aws_security_group.this.id
}
