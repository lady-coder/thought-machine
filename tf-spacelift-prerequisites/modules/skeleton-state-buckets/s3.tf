module "s3_state_file_networking" {

  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = "apps-networking-state"

  kms_key_arn = module.kms_s3.kms_key_arn
}

module "s3_state_file_infrastructure" {

  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = "apps-infrastructure-state"

  kms_key_arn = module.kms_s3.kms_key_arn
}

module "s3_state_file_data_infrastructure" {

  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = "data-infrastructure-state"

  kms_key_arn = module.kms_s3.kms_key_arn
}

module "s3_state_file_observability" {

  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment = var.environment
  component   = "apps-observability-state"

  kms_key_arn = module.kms_s3.kms_key_arn
}
