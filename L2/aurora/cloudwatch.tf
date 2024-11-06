module "rds_proxy_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.1"

  log_group_name         = "/aws/rds/proxy/${var.cluster_identifier}-proxy"
  cloudwatch_kms_key_arn = var.cloudwatch_cmk_arn
  retention_in_days      = var.rds_proxy_loggroup_retention
}

module "rds_metrics_log_group" {
  count   = var.monitoring_interval > 0 ? 1 : 0
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.1"

  log_group_name         = "RDSOSMetrics"
  cloudwatch_kms_key_arn = var.cloudwatch_cmk_arn
  retention_in_days      = var.rds_metrics_loggroup_retention
}
