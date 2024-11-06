module "jumphost_autoscaling_group" {
  source  = "spacelift.io/gft-blx/autoscaling-group/aws"
  version = "1.2.3"

  environment = var.environment
  component   = var.component
  context     = var.context
  prefix      = var.prefix

  vpc_id     = var.vpc_id
  subnet_ids = var.vpc_subnets

  security_group_rules_egress = var.jumphost_security_group_rules_egress

  enabled_metrics = var.enabled_metrics

  on_demand_base_capacity                  = 0
  on_demand_percentage_above_base_capacity = 0

  instance_type    = var.ec2_instance_type
  image_id         = var.ami_id
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  aws_iam_instance_profile_name = aws_iam_instance_profile.jumphost.name

  user_data = base64encode(templatefile("${path.module}/jumphost_user_data.sh.tpl", {
    kubectl_version = var.kubectl_version,
    cluster_name    = var.cluster_name,
    jumphost_role   = aws_iam_role.jumphost.arn
    region          = var.region
  }))

  downscale_after_working_hours = var.downscale_after_working_hours
  downscale_start_cron          = var.downscale_start_cron
  downscale_end_cron            = var.downscale_end_cron
}
