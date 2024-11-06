
resource "aws_sns_topic_subscription" "metric_alert" {
  for_each = toset(var.platform_cloudwatch_alert_emails)

  endpoint               = each.value
  protocol               = "email"
  topic_arn              = var.sns_metric_alert_topic_arn
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_policy" "metric_alert" {
  arn    = var.sns_metric_alert_topic_arn
  policy = data.aws_iam_policy_document.metric_alert_topic_policy.json
}
