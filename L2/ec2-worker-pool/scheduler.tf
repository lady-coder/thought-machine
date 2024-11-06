resource "aws_scheduler_schedule" "turn_off_spacelift_workers" {
  name       = lower("${var.environment}-${var.component}-schedule-turn-off-spacelift-workers")
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(${var.spacelift_workers_working_hours_end_cron})"

  target {
    arn      = aws_lambda_function.lambda_turn_off_spacelift_workers.arn
    role_arn = aws_iam_role.role_turn_off_spacelift_workers.arn
  }
}
