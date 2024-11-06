module "ec2_worker_pool" {
  source  = "spacelift.io/gft-blx/ec2-worker-pool/aws"
  version = "1.2.3"

  region      = var.region
  environment = var.environment
  component   = var.component
  vpc_id      = module.vpc.vpc_id

  max_size = 1

  ami_id            = var.spacelift_ec2_ami_id
  ec2_instance_type = var.spacelift_ec2_instance_type
  vpc_subnets       = module.vpc.private_subnets_ids

  # Token below is pool specific; not scoped to the wider Spacelift account
  # SPACELIFT_TOKEN: token received from Spacelift on worker pool creation
  # https://docs.spacelift.io/concepts/worker-pools
  configuration = <<-EOT
    export SPACELIFT_TOKEN="${module.spacelift_worker_pool.config}"
  EOT

  depends_on = [
    module.spacelift_log_groups
  ]
}

module "spacelift_worker_pool" {
  source  = "spacelift.io/gft-blx/spacelift-worker-pool/aws"
  version = "1.0.1"

  environment = var.environment
  component   = var.component
}
