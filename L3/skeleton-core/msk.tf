
module "apps_kafka" {
  source  = "spacelift.io/gft-blx/msk/aws"
  version = "1.0.6"

  vpc_id                                 = var.vpc_id
  subnet_ids                             = var.kafka_subnet_ids
  deploy_msk_in_public                   = var.deploy_msk_in_public
  enable_msk_configuration_public_access = var.enable_msk_configuration_public_access
  whitelisted_public_ingress_cidr_ranges = var.whitelisted_public_ingress_cidr_ranges
  enable_msk_configuration_for_tm        = var.enable_msk_configuration_for_tm

  cluster_name       = local.msk_cluster_name
  msk_cmk_arn        = var.msk_cmk_arn
  cloudwatch_cmk_arn = var.cloudwatch_cmk_arn
  kafka_version      = "3.3.1"

  number_of_broker_nodes = var.kafka_number_of_brokers
  broker_instance_type   = var.kafka_broker_instance_type
  broker_volume_size     = var.kafka_broker_volume_size

  client_authentication = {
    iam   = var.kafka_client_authentication.iam
    scram = var.kafka_client_authentication.scram
  }

  environment = var.environment
  component   = var.component

  sns_topic_arn = var.sns_metric_alert_topic_arn

  inbound_security_groups = [
    var.apps_jumphost_security_group_id,
    var.apps_control_plane_security_group_id
  ]

  enable_broker_logs_export = var.enable_broker_logs_export
}
