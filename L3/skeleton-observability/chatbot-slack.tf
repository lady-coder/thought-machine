resource "awscc_chatbot_slack_channel_configuration" "this" {
  for_each           = { for k, v in var.k8s_pod_alerts : k => v if v.slack_enable }
  configuration_name = "${each.key}-${var.environment}-${var.component}-slack-config"
  iam_role_arn       = aws_iam_role.this.arn
  slack_channel_id   = var.k8s_pod_alerts[each.key].slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  sns_topic_arns     = [aws_sns_topic.this["${each.key}"].arn]
  logging_level      = "NONE"
  guardrail_policies = ["arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess", aws_iam_policy.deny_log_access.arn]
}
