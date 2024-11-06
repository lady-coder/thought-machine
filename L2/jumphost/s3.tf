
module "jumphost_operational_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = var.component
  context     = local.bucket_context
  prefix      = var.prefix
  kms_key_arn = var.kms_s3_arn
}
