module "spacelift_log_groups" {
  count   = var.create_spacelift_worker_pool ? length(var.spacelift_loggroups) : 0
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = element(tolist(var.spacelift_loggroups), count.index)
  cloudwatch_kms_key_arn = var.kms_cloudwatch_arn
  retention_in_days      = var.spacelift_loggroup_retention
}
