module "spacelift_worker_pool_autoscaling_group" {
  source  = "spacelift.io/gft-blx/autoscaling-group/aws"
  version = "1.1.0"

  environment = var.environment
  component   = var.component
  context     = "spacelift-infra-worker"

  vpc_id     = var.vpc_id
  subnet_ids = var.vpc_subnets

  security_group_rules_egress = var.worker_pool_security_group_rules_egress

  enabled_metrics = var.enabled_metrics

  instance_type    = var.ec2_instance_type
  image_id         = var.ami_id
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = null

  aws_iam_instance_profile_name = aws_iam_instance_profile.worker.name

  user_data = base64encode(templatefile("${path.module}/worker.sh.tpl", {
    environment   = var.environment,
    component     = var.component,
    configuration = var.configuration,
    domain_name   = var.domain_name,
    region        = var.region
  }))
}
