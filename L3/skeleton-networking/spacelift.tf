module "ec2_worker_pool" {
  count   = var.create_ec2_worker_pool ? 1 : 0
  source  = "spacelift.io/gft-blx/ec2-worker-pool/aws"
  version = "1.2.5"

  depends_on = [
    module.spacelift_log_groups
  ]

  region      = var.region
  services    = var.services
  environment = var.environment
  component   = var.component
  vpc_id      = module.vpc.vpc_id

  kms_lambda_arn     = var.kms_lambda_arn
  kms_cloudwatch_arn = var.kms_cloudwatch_arn

  spacelift_workers_working_hours_end_cron = var.spacelift_workers_working_hours_end_cron

  max_size = 1

  ami_id            = var.spacelift_ec2_ami_id
  ec2_instance_type = var.spacelift_ec2_instance_type
  vpc_subnets       = module.vpc.private_subnets_ids

  # Token below is pool specific; not scoped to the wider Spacelift account
  # SPACELIFT_TOKEN: token received from Spacelift on worker pool creation
  # https://docs.spacelift.io/concepts/worker-pools
  configuration = <<-EOT
    export SPACELIFT_TOKEN="${var.create_spacelift_worker_pool ? module.spacelift_worker_pool[0].config : ""}"
  EOT
}

module "spacelift_worker_pool" {
  count   = var.create_spacelift_worker_pool ? 1 : 0
  source  = "spacelift.io/gft-blx/spacelift-worker-pool/aws"
  version = "1.0.1"

  environment = var.environment
  component   = var.component
}
