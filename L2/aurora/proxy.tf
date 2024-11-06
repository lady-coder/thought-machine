resource "aws_db_proxy" "this" {
  count = var.enable_rds_proxy ? 1 : 0

  name                   = "${var.cluster_identifier}-proxy"
  debug_logging          = false
  engine_family          = upper(var.engine_displayed_name)
  idle_client_timeout    = var.idle_client_timeout
  require_tls            = true
  role_arn               = aws_iam_role.rds_proxy[0].arn
  vpc_security_group_ids = [aws_security_group.rds_proxy[0].id]
  vpc_subnet_ids         = var.database_subnets

  dynamic "auth" {
    for_each = module.proxy_secret[count.index].secret_arns
    content {
      auth_scheme = "SECRETS"
      iam_auth    = "REQUIRED"
      secret_arn  = auth.value
    }
  }
}

resource "aws_db_proxy_endpoint" "this" {
  count = var.enable_rds_proxy ? 1 : 0

  db_proxy_name          = aws_db_proxy.this[0].name
  db_proxy_endpoint_name = "${var.cluster_identifier}-proxy-ro"
  vpc_subnet_ids         = var.database_subnets
  target_role            = "READ_ONLY"
}

resource "aws_db_proxy_default_target_group" "this" {
  count = var.enable_rds_proxy ? 1 : 0

  db_proxy_name = aws_db_proxy.this[0].id

  connection_pool_config {
    connection_borrow_timeout = var.connection_borrow_timeout
    max_connections_percent   = 100
  }
}

resource "aws_db_proxy_target" "this" {
  count = var.enable_rds_proxy ? 1 : 0

  db_cluster_identifier = aws_rds_cluster.this.id
  db_proxy_name         = aws_db_proxy.this[0].id
  target_group_name     = aws_db_proxy_default_target_group.this[0].name
}

resource "aws_iam_role" "rds_proxy" {
  count = var.enable_rds_proxy ? 1 : 0

  name               = "${var.cluster_identifier}-proxy"
  assume_role_policy = data.aws_iam_policy_document.rds_proxy_assume_role[count.index].json
}

data "aws_iam_policy_document" "rds_proxy_assume_role" {
  count = var.enable_rds_proxy ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "rds_proxy" {
  count = var.enable_rds_proxy ? 1 : 0

  statement {
    actions = ["secretsmanager:GetSecretValue"]
    effect  = "Allow"

    resources = module.proxy_secret[count.index].secret_arns
  }
  statement {
    actions = ["kms:Decrypt"]
    effect  = "Allow"

    resources = [var.secretsmanager_cmk_arn]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["secretsmanager.${var.region}.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "rds_proxy" {
  count = var.enable_rds_proxy ? 1 : 0

  name   = "${var.cluster_identifier}-proxy"
  role   = aws_iam_role.rds_proxy[0].name
  policy = data.aws_iam_policy_document.rds_proxy[count.index].json
}

module "proxy_secret" {
  count = var.enable_rds_proxy ? 1 : 0

  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secretsmanager_cmk_arn = var.secretsmanager_cmk_arn

  secret_names = local.db_credentials_secrets
}

resource "aws_security_group" "rds_proxy" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  count = var.enable_rds_proxy ? 1 : 0

  name        = "${var.cluster_identifier}-rds-proxy-sg"
  description = "Allow Inbound traffic from Security Groups and CIDRs"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "rds_proxy_ingress_cidr_blocks" {
  count = length(var.allowed_cidr_blocks) > 0 && var.enable_rds_proxy ? 1 : 0

  description       = "Allow inbound traffic from existing CIDR blocks for RDS proxy"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.rds_proxy[0].id
}

resource "aws_security_group_rule" "rds_proxy_ingress_groups" {
  count = length(var.inbound_security_groups) > 0 && var.enable_rds_proxy ? length(var.inbound_security_groups) : 0

  description              = "Allow inbound traffic from Security Groups for RDS proxy"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.inbound_security_groups[count.index]
  security_group_id        = aws_security_group.rds_proxy[0].id
}

resource "aws_security_group_rule" "rds_proxy_egress_groups" {
  count = var.enable_rds_proxy ? 1 : 0

  description              = "Allow outbound traffic from Security Groups for RDS proxy"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = -1
  source_security_group_id = aws_security_group.this.id
  security_group_id        = aws_security_group.rds_proxy[0].id
}
