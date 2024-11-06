
resource "aws_db_subnet_group" "this" {
  name        = "${var.cluster_identifier}-subnet-group"
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.database_subnets
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = "custom-${var.engine}-${local.major_version}-${local.minor_version}-${var.component}"
  family      = var.engine == "aurora-mysql" ? "${var.engine}${local.major_version}.${local.minor_version}" : "${var.engine}${local.major_version}"
  description = "Aurora ${var.engine_displayed_name} cluster parameter group"

  parameter {
    apply_method = "pending-reboot"
    name         = "max_connections"
    value        = lookup(local.max_conn, var.instance_class)
  }

  dynamic "parameter" {
    for_each = var.additional_cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_cluster" "this" {
  #checkov:skip=CKV2_AWS_27: Query Logging is not required
  #checkov:skip=CKV2_AWS_8: Backup is not required
  cluster_identifier = var.cluster_identifier

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.this.id]
  engine                          = var.engine
  engine_version                  = var.engine_version
  engine_mode                     = "provisioned"
  database_name                   = var.database_name
  port                            = var.port
  storage_encrypted               = true
  kms_key_id                      = var.aurora_cmk_arn

  iam_database_authentication_enabled = true
  master_username                     = var.master_username
  master_password                     = random_password.this.result

  backup_retention_period      = var.backup_retention_period
  preferred_maintenance_window = var.preferred_maintenance_window

  deletion_protection = true
  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    "blx:autostop"  = "yes"
    "blx:autostart" = "yes"
  }

  depends_on = [
    aws_security_group.this,
    aws_db_subnet_group.this
  ]
}

resource "aws_rds_cluster_instance" "main" {
  #checkov:skip=CKV_AWS_118: "Ensure that enhanced monitoring is enabled for Amazon RDS instances"
  #checkov:skip=CKV_AWS_226: "Ensure DB instance gets all minor upgrades automatically"
  count                = var.number_of_instances
  identifier           = "${var.cluster_identifier}-${count.index}"
  cluster_identifier   = aws_rds_cluster.this.id
  instance_class       = var.instance_class
  db_subnet_group_name = aws_db_subnet_group.this.name
  publicly_accessible  = false

  engine         = aws_rds_cluster.this.engine
  engine_version = aws_rds_cluster.this.engine_version

  preferred_maintenance_window = var.preferred_maintenance_window

  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_enabled ? var.aurora_cmk_arn : null

  apply_immediately          = false
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  monitoring_interval        = var.monitoring_interval
  monitoring_role_arn        = var.monitoring_interval > 0 ? aws_iam_role.rds_enhanced_monitoring[0].arn : null

  depends_on = [
    aws_rds_cluster.this,
    aws_db_subnet_group.this,
    aws_iam_role.rds_enhanced_monitoring
  ]

  lifecycle {
    ignore_changes = [engine_version]
  }
}

module "aurora_writer_endpoint_ssm_parameter" {
  source  = "spacelift.io/gft-blx/ssm-parameter/aws"
  version = "1.0.1"

  cmk_key_id = var.ssm_parameters_cmk_arn

  environment    = var.environment
  component      = var.component
  resource       = "aurora"
  parameter_name = "${var.cluster_identifier}-writer-endpoint"
  description    = "Cluster read-write endpoint"
  value          = aws_rds_cluster.this.endpoint
}

module "aurora_reader_endpoint_ssm_parameter" {
  source  = "spacelift.io/gft-blx/ssm-parameter/aws"
  version = "1.0.1"

  cmk_key_id = var.ssm_parameters_cmk_arn

  environment    = var.environment
  component      = var.component
  resource       = "aurora"
  parameter_name = "${var.cluster_identifier}-reader-endpoint"
  description    = "Cluster read-only endpoint"
  value          = aws_rds_cluster.this.reader_endpoint
}
