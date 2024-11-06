
# Downscaling the chosen node group ASG after working hours to achieve the cost reduction
resource "aws_autoscaling_schedule" "downscaling_start_schedule" {
  for_each = {
    for k, v in var.node_groups : k => v
    if v.downscale_after_working_hours == true
  }

  scheduled_action_name  = "downscaling-after-working-hours"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = each.value.downscale_schedule_cron
  time_zone              = "Etc/UTC"
  autoscaling_group_name = lookup(aws_eks_node_group.this, each.key, null).resources[0].autoscaling_groups[0].name
}

# Setting the proper size of chosen node group ASG before working hours
resource "aws_autoscaling_schedule" "downscaling_end_schedule" {
  for_each = {
    for k, v in var.node_groups : k => v
    if v.downscale_after_working_hours == true
  }

  scheduled_action_name  = "upscaling-before-working-hours"
  min_size               = each.value.min_size
  max_size               = each.value.max_size
  desired_capacity       = each.value.desired_capacity
  recurrence             = each.value.upscale_schedule_cron
  time_zone              = "Etc/UTC"
  autoscaling_group_name = lookup(aws_eks_node_group.this, each.key, null).resources[0].autoscaling_groups[0].name
}
