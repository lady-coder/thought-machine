module "spacelift_log_groups" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  for_each = var.spacelift_loggroups

  log_group_name         = each.key
  cloudwatch_kms_key_arn = var.kms_cloudwatch_arn
  retention_in_days      = var.spacelift_loggroup_retention
}
