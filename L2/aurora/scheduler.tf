resource "aws_scheduler_schedule" "turn_on_aurora" {
  name       = lower("${var.environment}-${var.component}-schedule-turn-on-${var.cluster_identifier}")
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(${var.aurora_working_hours_start_cron})"

  target {
    arn      = aws_lambda_function.lambda_turn_on_dbs.arn
    role_arn = aws_iam_role.role_turn_on_off_dbs.arn
  }
}

resource "aws_scheduler_schedule" "turn_off_aurora" {
  name       = lower("${var.environment}-${var.component}-schedule-turn-off-${var.cluster_identifier}")
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(${var.aurora_working_hours_end_cron})"

  target {
    arn      = aws_lambda_function.lambda_turn_off_dbs.arn
    role_arn = aws_iam_role.role_turn_on_off_dbs.arn
  }
}