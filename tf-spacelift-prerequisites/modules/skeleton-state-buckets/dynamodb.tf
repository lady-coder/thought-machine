module "dynamodb_state_file_networking" {

  source  = "spacelift.io/gft-blx/dynamodb/aws"
  version = "1.0.4"

  env       = var.environment
  component = "apps-networking-lock"
  prefix    = var.prefix

  kms_key_arn = module.kms_db.kms_key_arn
  hash_key    = "LockID"

  attributes = [{
    name = "LockID"
    type = "S"
  }]
}

module "dynamodb_state_file_infrastructure" {

  source  = "spacelift.io/gft-blx/dynamodb/aws"
  version = "1.0.4"

  env       = var.environment
  component = "apps-infrastructure-lock"
  prefix    = var.prefix

  kms_key_arn = module.kms_db.kms_key_arn
  hash_key    = "LockID"

  attributes = [{
    name = "LockID"
    type = "S"
  }]
}

module "dynamodb_state_file_data_infrastructure" {

  source  = "spacelift.io/gft-blx/dynamodb/aws"
  version = "1.0.4"

  env       = var.environment
  component = "data-infrastructure-lock"
  prefix    = var.prefix

  kms_key_arn = module.kms_db.kms_key_arn
  hash_key    = "LockID"

  attributes = [{
    name = "LockID"
    type = "S"
  }]
}

module "dynamodb_state_file_observability" {

  source  = "spacelift.io/gft-blx/dynamodb/aws"
  version = "1.0.4"

  env       = var.environment
  component = "apps-observability-lock"
  prefix    = var.prefix

  kms_key_arn = module.kms_db.kms_key_arn
  hash_key    = "LockID"

  attributes = [{
    name = "LockID"
    type = "S"
  }]
}
