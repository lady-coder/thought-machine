
# Downscaling the jumphost ASG after working hours to achieve the cost reduction
resource "aws_autoscaling_schedule" "downscaling_start_schedule" {
  count = var.downscale_after_working_hours ? 1 : 0

  scheduled_action_name  = "downscaling-after-working-hours"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.downscale_start_cron
  time_zone              = "Etc/UTC"
  autoscaling_group_name = aws_autoscaling_group.this.name
}

# Setting the proper size of jumphost ASG before working hours
resource "aws_autoscaling_schedule" "downscaling_end_schedule" {
  count = var.downscale_after_working_hours ? 1 : 0

  scheduled_action_name  = "upscaling-before-working-hours"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity
  recurrence             = var.downscale_end_cron
  time_zone              = "Etc/UTC"
  autoscaling_group_name = aws_autoscaling_group.this.name
}
