resource "aws_mwaa_environment" "mwaa" {
  name              = var.mwaa_name
  airflow_version   = var.airflow_version
  environment_class = var.environment_class
  min_workers       = var.min_workers
  max_workers       = var.max_workers
  kms_key           = var.kms_key

  dag_s3_path                    = var.dag_s3_path
  plugins_s3_object_version      = var.plugins_s3_object_version
  plugins_s3_path                = var.plugins_s3_path
  requirements_s3_path           = var.requirements_s3_path
  requirements_s3_object_version = var.requirements_s3_object_version
  schedulers                     = var.schedulers
  execution_role_arn             = local.execution_role_arn
  airflow_configuration_options  = local.airflow_configuration_options

  source_bucket_arn               = var.source_bucket_arn
  webserver_access_mode           = var.webserver_access_mode
  weekly_maintenance_window_start = var.weekly_maintenance_window_start

  network_configuration {
    security_group_ids = [aws_security_group.mwaa.id]
    subnet_ids         = var.private_subnet_ids
  }

  logging_configuration {
    dag_processing_logs {
      enabled   = try(var.logging_configuration.dag_processing_logs.enabled, true)
      log_level = try(var.logging_configuration.dag_processing_logs.log_level, "DEBUG")
    }

    scheduler_logs {
      enabled   = try(var.logging_configuration.scheduler_logs.enabled, true)
      log_level = try(var.logging_configuration.scheduler_logs.log_level, "INFO")
    }

    task_logs {
      enabled   = try(var.logging_configuration.task_logs.enabled, true)
      log_level = try(var.logging_configuration.task_logs.log_level, "WARNING")
    }

    webserver_logs {
      enabled   = try(var.logging_configuration.webserver_logs.enabled, true)
      log_level = try(var.logging_configuration.webserver_logs.log_level, "ERROR")
    }

    worker_logs {
      enabled   = try(var.logging_configuration.worker_logs.enabled, true)
      log_level = try(var.logging_configuration.worker_logs.log_level, "CRITICAL")
    }
  }

  lifecycle {
    ignore_changes = [
      plugins_s3_object_version,
      requirements_s3_object_version
    ]
  }

  depends_on = [
    aws_iam_role_policy.mwaa,
    aws_cloudwatch_log_group.mwaa,
  ]
}

resource "aws_iam_role" "mwaa" {
  count = var.create_iam_role ? 1 : 0

  name                  = var.iam_role_name != null ? var.iam_role_name : null
  description           = "MWAA IAM Role"
  assume_role_policy    = data.aws_iam_policy_document.mwaa_assume.json
  force_detach_policies = var.force_detach_policies
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary
}

resource "aws_iam_role_policy" "mwaa" {
  count = var.create_iam_role ? 1 : 0

  name_prefix = "mwaa-executor"
  role        = aws_iam_role.mwaa[0].id
  policy      = data.aws_iam_policy_document.mwaa.json
}

resource "aws_iam_role_policy_attachment" "mwaa" {
  for_each   = local.iam_role_additional_policies
  policy_arn = each.key
  role       = aws_iam_role.mwaa[0].id
}

resource "aws_security_group" "mwaa" {
  name        = lower("${var.mwaa_name}-sg")
  description = "Security group for MWAA environment"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "mwaa_sg_inbound" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "all"
  source_security_group_id = aws_security_group.mwaa.id
  security_group_id        = aws_security_group.mwaa.id
  description              = "Amazon MWAA inbound access"
}

resource "aws_security_group_rule" "mwaa_sg_inbound_vpn" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mwaa.id
  security_group_id        = aws_security_group.mwaa.id
  description              = "VPN Access for Airflow UI"
}

#tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "mwaa_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mwaa.id
  description       = "Amazon MWAA outbound access"
}
