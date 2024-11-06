resource "aws_sns_topic" "this" {
  for_each          = var.k8s_pod_alerts
  kms_master_key_id = var.kms_cmk_sns
  name              = "${join("-", compact([var.prefix, var.environment]))}-${each.key}-metric-alarm-eks-pod"
  display_name      = "${join("-", compact([var.prefix, var.environment]))}-${each.key}-metric-alarm-eks-pod"
}

resource "aws_sns_topic_subscription" "this" {
  for_each = merge([
    for platform, alert in var.k8s_pod_alerts : {
      for email in alert.email_recipients : "${platform}-${email}" => {
        email    = email
        platform = platform
      }
    }
  ]...)
  endpoint               = each.value.email
  protocol               = "email"
  topic_arn              = aws_sns_topic.this["${each.value.platform}"].arn
  endpoint_auto_confirms = true
}
