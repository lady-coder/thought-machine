module "apps_aurora" {
  source  = "spacelift.io/gft-blx/aurora/aws"
  version = "1.1.18"

  cluster_identifier              = local.aurora_cluster_name
  engine_version                  = "14.5"
  vpc_id                          = var.vpc_id
  database_subnets                = var.aurora_subnet_ids
  lambdas_subnets                 = var.lambdas_subnet_ids
  instance_class                  = var.aurora_instance_class
  number_of_instances             = var.aurora_number_of_instances
  aurora_working_hours_start_cron = var.aurora_working_hours_start_cron
  aurora_working_hours_end_cron   = var.aurora_working_hours_end_cron

  enable_rds_proxy       = var.enable_rds_proxy
  db_credentials_secrets = var.db_credentials_secrets

  aurora_cmk_arn         = var.aurora_cmk_arn
  secretsmanager_cmk_arn = var.secretsmanager_cmk_arn
  ssm_parameters_cmk_arn = var.ssm_cmk_arn
  cloudwatch_cmk_arn     = var.cloudwatch_cmk_arn
  kms_lambda_arn         = var.kms_lambda_arn
  password_secret_name   = "aurora"

  backup_retention_period      = var.backup_retention_period
  preferred_maintenance_window = var.preferred_maintenance_window
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade

  sns_topic_arn       = var.sns_metric_alert_topic_arn
  monitoring_interval = var.monitoring_interval

  environment = var.environment
  component   = var.component
  region      = var.region

  inbound_security_groups = [
    var.apps_jumphost_security_group_id,
    var.apps_control_plane_security_group_id
  ]
}
