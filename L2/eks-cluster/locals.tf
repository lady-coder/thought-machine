data "aws_caller_identity" "this" {}

locals {

  containerinsights_performance_log_group_name = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/performance"
  containerinsights_application_log_group_name = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/application"
  containerinsights_platform_log_group_name    = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/platform"
  containerinsights_dataplane_log_group_name   = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/dataplane"
  containerinsights_host_log_group_name        = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/host"
  containerinsights_prometheus_log_group_name  = "${var.log_group_prefix}/${var.cluster_name}/containerinsights/prometheus"
  containerinsights_cluster_log_group_name     = "${var.log_group_prefix}/${var.cluster_name}/cluster"

  metric_log_error = {
    log-errors-medium = {
      threshold = var.k8s_logs_alert_medium_treshold_5minutes
    },
    log-errors-high = {
      threshold = var.k8s_logs_alert_high_treshold_5minutes
    },
    log-errors-superhigh = {
      threshold = var.k8s_logs_alert_superhigh_treshold_5minutes
    }
  }
}
