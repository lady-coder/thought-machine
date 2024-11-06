resource "aws_sns_topic" "charges_anomaly" {
  provider          = aws.billing
  kms_master_key_id = aws_kms_key.this.id
  name              = "${var.environment}-charges-alert"
  display_name      = "${var.environment}-charges-alert"
}

resource "aws_sns_topic_subscription" "charges_anomaly" {
  provider               = aws.billing
  for_each               = var.subscriber_emails
  endpoint               = each.key
  protocol               = "email"
  topic_arn              = aws_sns_topic.charges_anomaly.arn
  endpoint_auto_confirms = true
}
