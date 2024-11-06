resource "aws_security_group" "broker_nodes" {
  vpc_id      = var.vpc_id
  name        = "${var.environment}-${var.component}-msk-sg"
  description = "Allow inbound traffic from Security Groups and CIDRs. Allow all outbound traffic"
}

resource "aws_security_group_rule" "ingress" {
  count = length(var.inbound_security_groups) > 0 ? length(var.inbound_security_groups) : 0

  description              = "Allow inbound traffic from other cloud resources by whitelisting their Security Groups"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.inbound_security_groups[count.index]
  security_group_id        = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "ingress_sasl_private" {
  count = length(var.whitelisted_private_ingress_cidr_ranges) > 0 ? 1 : 0

  description       = "Allow SASL private inbound traffic"
  type              = "ingress"
  from_port         = 9096
  to_port           = 9096
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_private_ingress_cidr_ranges
  security_group_id = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "ingress_iam_private" {
  count = length(var.whitelisted_private_ingress_cidr_ranges) > 0 ? 1 : 0

  description       = "Allow IAM private inbound traffic"
  type              = "ingress"
  from_port         = 9098
  to_port           = 9098
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_private_ingress_cidr_ranges
  security_group_id = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "ingress_sasl_public" {
  count = length(var.whitelisted_public_ingress_cidr_ranges) > 0 ? 1 : 0

  description       = "Allow SASL public inbound traffic"
  type              = "ingress"
  from_port         = 9196
  to_port           = 9196
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_public_ingress_cidr_ranges
  security_group_id = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "ingress_iam_public" {
  count = length(var.whitelisted_public_ingress_cidr_ranges) > 0 ? 1 : 0

  description       = "Allow IAM public inbound traffic"
  type              = "ingress"
  from_port         = 9198
  to_port           = 9198
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_public_ingress_cidr_ranges
  security_group_id = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "ingress_zookeeper" {
  count = length(var.whitelisted_private_ingress_cidr_ranges) > 0 ? 1 : 0

  description       = "Allow inbound traffic to the Zookeeper"
  type              = "ingress"
  from_port         = 2182
  to_port           = 2182
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_private_ingress_cidr_ranges
  security_group_id = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "public_ingress_zookeeper" {
  count = length(var.whitelisted_public_ingress_cidr_ranges) > 0 ? 1 : 0

  description       = "Allow public inbound traffic to the Zookeeper"
  type              = "ingress"
  from_port         = 2182
  to_port           = 2182
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_public_ingress_cidr_ranges
  security_group_id = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "msk_connect" {
  description              = "Allow connectivity between MSK nodes and MSK Connect workers"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.broker_nodes.id
  security_group_id        = aws_security_group.broker_nodes.id
}

resource "aws_security_group_rule" "egress" {
  description       = "Allow all egress traffic for MSK"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.broker_nodes.id
}
