module "containerinsights_performance_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "/aws/containerinsights/${var.cluster_name}/performance"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_metrics_retention_in_days
}

module "containerinsights_application_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/application"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_logs_retention_in_days
}

module "containerinsights_platform_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/platform"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_logs_retention_in_days
}

module "containerinsights_dataplane_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/dataplane"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_metrics_retention_in_days
}

module "containerinsights_host_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/host"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_metrics_retention_in_days
}

module "containerinsights_prometheus_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/prometheus"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_metrics_retention_in_days
}

module "containerinsights_cluster_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = "${var.log_group_prefix}/${var.cluster_name}/cluster"
  cloudwatch_kms_key_arn = var.container_insights_log_group_cmk_arn
  retention_in_days      = var.container_insights_logs_retention_in_days
}
