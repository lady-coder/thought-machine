module "eks_jumphost_admin" {
  source  = "spacelift.io/gft-blx/jumphost/aws"
  version = "1.2.16"

  region      = var.region
  environment = var.environment
  component   = var.component
  prefix      = var.prefix
  context     = "jumphost-admin"
  vpc_id      = var.vpc_id

  cluster_name    = local.eks_cluster_name
  kubectl_version = var.kubectl_version

  ami_id      = var.eks_jumphost_ec2_ami_id
  vpc_subnets = var.subnet_ids

  kms_s3_arn         = var.eks_s3_cmk_arn
  kms_cloudwatch_arn = var.kms_cloudwatch_arn
  kms_lambda_arn     = var.kms_lambda_arn

  downscale_after_working_hours = var.downscale_jumphost_after_working_hours
  downscale_start_cron          = var.working_hours_end_cron
  downscale_end_cron            = var.working_hours_start_cron
}
