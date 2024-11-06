module "dynamodb_state_file_github_automations" {

  source  = "spacelift.io/gft-blx/dynamodb/aws"
  version = "1.0.4"

  env       = var.environment
  component = "github-automations-lock"
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
  component = "infrastructure-lock"
  prefix    = var.prefix

  kms_key_arn = module.kms_db.kms_key_arn
  hash_key    = "LockID"

  attributes = [{
    name = "LockID"
    type = "S"
  }]
}

module "dynamodb_state_file_networking" {

  source  = "spacelift.io/gft-blx/dynamodb/aws"
  version = "1.0.4"

  env       = var.environment
  component = "networking-lock"
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
  component = "observability-lock"
  prefix    = var.prefix

  kms_key_arn = module.kms_db.kms_key_arn
  hash_key    = "LockID"

  attributes = [{
    name = "LockID"
    type = "S"
  }]
}
