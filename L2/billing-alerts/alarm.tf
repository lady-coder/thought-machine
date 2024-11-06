resource "aws_cloudwatch_metric_alarm" "charges_anomaly" {
  provider = aws.billing

  alarm_name          = "${var.environment}/charges-anomaly"
  comparison_operator = "GreaterThanUpperThreshold"
  evaluation_periods  = "1"
  threshold_metric_id = "anomaly"
  alarm_description   = "Anomaly in estimated costs"
  alarm_actions       = [aws_sns_topic.charges_anomaly.arn]
  ok_actions          = [aws_sns_topic.charges_anomaly.arn]

  metric_query {
    id          = "anomaly"
    expression  = "ANOMALY_DETECTION_BAND(charges)"
    label       = "Estimated Charges"
    return_data = "true"
  }

  metric_query {
    id          = "charges"
    return_data = "true"
    metric {
      metric_name = "EstimatedCharges"
      namespace   = "AWS/Billing"
      period      = "21600" # 6h
      stat        = "Maximum"
    }
  }
}
