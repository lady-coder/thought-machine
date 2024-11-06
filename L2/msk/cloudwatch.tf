
module "msk_broker_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = local.msk_brokers_log_group_name
  cloudwatch_kms_key_arn = var.cloudwatch_cmk_arn
  retention_in_days      = var.kafka_broker_loggroup_retention
}

module "msk_connectors_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.0"

  log_group_name         = local.msk_connectors_log_group_name
  cloudwatch_kms_key_arn = var.cloudwatch_cmk_arn
  retention_in_days      = var.kafka_connector_loggroup_retention
}
