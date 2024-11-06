resource "aws_autoscaling_policy" "this" {
  count = var.enable_asg_policy ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.this.name
  name                   = "${local.name}-policy"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value     = var.asg_policy_target_value
    disable_scale_in = var.asg_disable_scale_in
  }
}

resource "aws_autoscaling_lifecycle_hook" "this" {
  count = var.enable_asg_policy ? 1 : 0

  name                   = "${local.name}-lifecycle-hook"
  autoscaling_group_name = aws_autoscaling_group.this.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = var.lifecycle_hook_timeout
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
}
