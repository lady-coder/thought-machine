resource "aws_sns_topic" "metric_alert" {
  name              = "${join("-", compact([var.prefix, var.environment, var.component]))}-metric-alert"
  display_name      = "${join("-", compact([var.prefix, var.environment, var.component]))}-metric-alert"
  kms_master_key_id = var.sns_cmk_arn
}
