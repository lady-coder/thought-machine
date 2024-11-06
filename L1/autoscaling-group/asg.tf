resource "aws_autoscaling_group" "this" {
  depends_on = [aws_launch_template.this]

  name_prefix         = "${local.name}-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_ids

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.spot_allocation_strategy
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.this.id
        version            = aws_launch_template.this.latest_version
      }
    }
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = local.name
    propagate_at_launch = true
  }

  enabled_metrics           = var.enabled_metrics
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  default_cooldown          = var.default_cooldown
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      desired_capacity,
    ]
  }
}

resource "aws_launch_template" "this" {
  name_prefix            = local.name
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = var.user_data
  ebs_optimized          = true

  iam_instance_profile {
    name = var.aws_iam_instance_profile_name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.name}"
    }
  }
}
