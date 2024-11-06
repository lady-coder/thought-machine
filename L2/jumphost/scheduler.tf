resource "aws_scheduler_schedule" "turn_off_jumphost" {
  name       = lower("${local.name}-schedule-turn-off-jumphost")
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(15 minutes)"

  target {
    arn      = aws_lambda_function.lambda_turn_off_jumphost.arn
    role_arn = aws_iam_role.role_turn_off_jumphost.arn
  }
}
