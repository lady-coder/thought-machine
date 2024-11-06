
resource "aws_cloudwatch_metric_alarm" "restart_number" {
  for_each = merge([
    for platform, alert in var.k8s_pod_alerts : {
      for pod in alert.pods : "${pod.pod_name}" => {
        pod      = pod
        platform = platform
      }
    }
  ]...)
  alarm_name          = "${var.environment}/${each.value.platform}/eks/${local.eks_cluster_name}/${each.value.pod.pod_name}/pod-restarted-too-many"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "pod_number_of_container_restarts"
  namespace           = "ContainerInsights"
  period              = 300
  statistic           = "Sum"
  threshold           = try(each.value.pod.acceptable_restarts_per_5_minutes, 0)
  alarm_description   = "${each.value.platform} pods restarted too many times per 5 minutes window"
  alarm_actions       = [aws_sns_topic.this["${each.value.platform}"].arn]
  ok_actions          = [aws_sns_topic.this["${each.value.platform}"].arn]
  dimensions = {
    "PodName"     = "${each.value.pod.pod_name}"
    "ClusterName" = local.eks_cluster_name
    "Namespace"   = "${each.value.pod.namespace}"
  }
}

resource "aws_cloudwatch_metric_alarm" "service_availability" {
  for_each = merge([
    for platform, alert in var.k8s_pod_alerts : {
      for pod in alert.pods : "${pod.pod_name}" => {
        pod      = pod
        platform = platform
      } if try("${pod.monitor_availability}", "false") == "true"
    }
  ]...)
  alarm_name          = "${var.environment}/${each.value.platform}/eks/${local.eks_cluster_name}/${each.value.pod.pod_name}/service-not-responding"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "probe_success"
  namespace           = "ContainerInsights/Prometheus"
  period              = 300
  statistic           = "Minimum"
  threshold           = 0
  alarm_description   = "${each.value.platform} service failed at least one availability check per 5 minutes window"
  alarm_actions       = [aws_sns_topic.this["${each.value.platform}"].arn]
  ok_actions          = [aws_sns_topic.this["${each.value.platform}"].arn]
  dimensions = {
    "ServiceName" = try("${each.value.pod.service}", "${each.value.pod.pod_name}")
    "ClusterName" = local.eks_cluster_name
    "Namespace"   = "${each.value.pod.namespace}"
  }
}


resource "aws_cloudwatch_metric_alarm" "cpu_utilisation" {
  for_each = merge([
    for platform, alert in var.k8s_pod_alerts : {
      for pod in alert.pods : "${pod.pod_name}" => {
        pod      = pod
        platform = platform
      }
    }
  ]...)
  alarm_name          = "${var.environment}/${each.value.platform}/eks/${local.eks_cluster_name}/${each.value.pod.pod_name}/cpu-utilisation-too-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "pod_cpu_utilization"
  namespace           = "ContainerInsights"
  period              = 600
  statistic           = "Average"
  threshold           = try(each.value.pod.acceptable_pod_cpu_utilisation_per_10_minutes, 90)
  alarm_description   = "${each.value.platform} pods have too high cpu utilisation per 10 minutes window"
  alarm_actions       = [aws_sns_topic.this["${each.value.platform}"].arn]
  ok_actions          = [aws_sns_topic.this["${each.value.platform}"].arn]
  dimensions = {
    "PodName"     = "${each.value.pod.pod_name}"
    "ClusterName" = local.eks_cluster_name
    "Namespace"   = "${each.value.pod.namespace}"
  }
}

resource "aws_cloudwatch_metric_alarm" "errors_5xx" {
  for_each = merge([
    for platform, alert in var.k8s_pod_alerts : {
      for pod in alert.pods : "${pod.pod_name}" => {
        pod      = pod
        platform = platform
      }
    } if platform != "platform"
  ]...)
  alarm_name          = "${var.environment}/${each.value.platform}/eks/${local.eks_cluster_name}/${each.value.pod.pod_name}/too-many-http5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  threshold           = try(each.value.pod.acceptable_http_5xx_errors_percentage, 5)
  alarm_description   = "${each.value.platform} pods produced too many http 5xx errors in 10 minutes window"
  alarm_actions       = [aws_sns_topic.this["${each.value.platform}"].arn]
  ok_actions          = [aws_sns_topic.this["${each.value.platform}"].arn]

  metric_query {
    id          = "percentage_of_HTTP_5xx_requests"
    expression  = "100*envoy_http_downstream_rq_5xx/envoy_http_downstream_rq_total"
    label       = "percentage_of_HTTP_5xx_requests"
    return_data = "true"
  }

  metric_query {
    id = "envoy_http_downstream_rq_5xx"

    metric {
      metric_name = "envoy_http_downstream_rq_xx"
      namespace   = "ContainerInsights/Prometheus"
      period      = 600
      stat        = "Average"
      dimensions = {
        "ClusterName"                    = local.eks_cluster_name
        "Namespace"                      = "${each.value.pod.namespace}"
        "envoy_http_conn_manager_prefix" = "ingress"
        "envoy_response_code_class"      = 5
      }
    }
  }

  metric_query {
    id = "envoy_http_downstream_rq_total"

    metric {
      metric_name = "envoy_http_downstream_rq_total"
      namespace   = "ContainerInsights/Prometheus"
      period      = 600
      stat        = "Average"
      dimensions = {
        "ClusterName" = local.eks_cluster_name
        "Namespace"   = "${each.value.pod.namespace}"
      }
    }
  }
}
