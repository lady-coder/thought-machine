resource "aws_security_group" "this" {
  name        = "${var.cluster_identifier}-sg"
  description = "Allow Inbound traffic from Security Groups and CIDRs"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_cidr_block" {
  count             = length(var.allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from existing CIDR blocks"
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_group" {
  count                    = length(var.inbound_security_groups) > 0 ? length(var.inbound_security_groups) : 0
  description              = "Allow inbound traffic from Security Groups"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.inbound_security_groups[count.index]
  security_group_id        = aws_security_group.this.id
}

#security group for lambdas turn on/off dbs
resource "aws_security_group" "lambdas_turn_on_off_sg" {
  name        = "${var.environment}/${var.component}-lambdas-turn-on-off-${var.cluster_identifier}-sg"
  description = "Allow Outbound traffic"
  vpc_id      = var.vpc_id

  egress {
    description = "Allow Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_password" "this" {
  length  = 20
  special = false
}

module "master_password_secret" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secretsmanager_cmk_arn = var.secretsmanager_cmk_arn

  secret_names = [
    "/${var.environment}/${var.component}/platform/${var.password_secret_name}/master-password"
  ]
}

resource "aws_secretsmanager_secret_version" "initial_master_password" {
  secret_id     = module.master_password_secret.secret_ids[0]
  secret_string = random_password.this.result
  lifecycle {
    ignore_changes = [version_stages]
  }
}
