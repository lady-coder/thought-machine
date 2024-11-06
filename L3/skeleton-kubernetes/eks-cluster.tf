module "eks_cluster" {
  source  = "spacelift.io/gft-blx/eks-cluster/aws"
  version = "1.0.10"

  environment  = var.environment
  region       = var.region
  cluster_name = local.eks_cluster_name

  vpc_id     = var.vpc_id
  vpc_cird   = var.vpc_cidr
  subnet_ids = var.subnet_ids

  kubernetes_version        = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types
  endpoint_public_access    = var.endpoint_public_access

  cluster_encryption_cmk_arn           = var.cluster_encryption_cmk_arn
  container_insights_log_group_cmk_arn = var.container_insights_log_group_cmk_arn

  sns_topic_arn                                = aws_sns_topic.metric_alert.arn
  filter_pattern                               = var.filter_pattern
  k8s_logs_alert_high_treshold_5minutes        = var.k8s_logs_alert_high_treshold_5minutes
  k8s_logs_alert_medium_treshold_5minutes      = var.k8s_logs_alert_medium_treshold_5minutes
  k8s_logs_alert_superhigh_treshold_5minutes   = var.k8s_logs_alert_superhigh_treshold_5minutes
  container_insights_logs_retention_in_days    = var.container_insights_logs_retention_in_days
  container_insights_metrics_retention_in_days = var.container_insights_metrics_retention_in_days

  inbound_security_groups = concat(
    var.application_security_groups
  )

  control_plane_allowed_ip_ranges = concat(
    var.control_plane_allowed_ip_ranges
  )
}
