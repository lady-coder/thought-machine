module "s3_state_file_networking" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = "tm-networking-state"

  kms_key_arn = module.kms_s3.kms_key_arn
}

module "s3_state_file_infrastructure" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = "tm-infrastructure-state"

  kms_key_arn = module.kms_s3.kms_key_arn
}
