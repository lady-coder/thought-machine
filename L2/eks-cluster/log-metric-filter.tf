
resource "aws_cloudwatch_log_metric_filter" "error_log_metric_filter" {
  name           = "count-error-log-metric-filter"
  pattern        = var.filter_pattern
  log_group_name = module.containerinsights_application_log_group.log_group_name

  metric_transformation {
    name      = "error-log-metric-filter-count"
    namespace = "ErrorMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_log_metric_filter" {
  for_each            = local.metric_log_error
  alarm_name          = "${var.environment}/platform/eks/${aws_eks_cluster.this.id}/${each.key}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "error-log-metric-filter-count"
  namespace           = "ErrorMetrics"
  period              = "300"
  statistic           = "Average"
  threshold           = each.value.threshold
  alarm_description   = "This metric monitors the reoccurrence of the keyword ${var.filter_pattern} in log group: ${module.containerinsights_application_log_group.log_group_name}"
  actions_enabled     = "true"
  alarm_actions       = [var.sns_topic_arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "argo_log_metric_filter" {
  name           = "count-argo-log-metric-filter"
  pattern        = "attemp"
  log_group_name = module.containerinsights_platform_log_group.log_group_name

  metric_transformation {
    name      = "argocd-log-metric-filter-count"
    namespace = "ArgocdMetrics"
    value     = "1"
  }
  depends_on = [
    module.containerinsights_platform_log_group
  ]
}

resource "aws_cloudwatch_metric_alarm" "argo_log_metric_filter" {
  alarm_name          = "${var.environment}/platform/eks/${aws_eks_cluster.this.id}/argocd-not-sync"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "argocd-log-metric-filter-count"
  namespace           = "ArgocdMetrics"
  period              = "600"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors the reoccurrence of the keyword attemp in log group: ${module.containerinsights_platform_log_group.log_group_name}"
  actions_enabled     = "true"
  alarm_actions       = [var.sns_topic_arn]
  treat_missing_data  = "notBreaching"
}
