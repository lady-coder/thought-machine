output "sns_topic_arns" {
  description = "Map of sns topics arn"
  value = {
    for topic, arns in aws_sns_topic.this : topic => arns.arn
  }
}