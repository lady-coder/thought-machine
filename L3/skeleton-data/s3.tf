module "datatech_platformtests_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment         = var.environment
  component           = var.component
  context             = "platformtests"
  enable_versioning   = var.enable_versioning
  kms_key_arn         = var.kms_s3_arn
  object_lock_enabled = var.object_lock_enabled
}

module "datatech_airflowdags_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment         = var.environment
  component           = var.component
  context             = "airflowdags"
  enable_versioning   = var.enable_versioning
  kms_key_arn         = var.kms_s3_arn
  object_lock_enabled = var.object_lock_enabled
}

module "datatech_sparkjobs_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment         = var.environment
  component           = var.component
  context             = "sparkjobs"
  enable_versioning   = var.enable_versioning
  kms_key_arn         = var.kms_s3_arn
  object_lock_enabled = var.object_lock_enabled
}

module "datatech_athenaoutputs_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = var.component
  context              = "athenaoutputs"
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.athena_outputs_bucket.json
}

module "datalake_bronze_customers_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment         = var.environment
  component           = "datalake"
  context             = join("-", compact(["bronze", "customers"]))
  enable_versioning   = var.enable_versioning
  kms_key_arn         = var.kms_s3_arn
  object_lock_enabled = var.object_lock_enabled
}

module "datalake_silver_customers_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = "datalake"
  context              = join("-", compact(["silver", "customers"]))
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.datalake_silver_customers_bucket.json
}

module "datalake_gold_customers_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = "datalake"
  context              = join("-", compact(["gold", "customers"]))
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.datalake_gold_customers_bucket.json
}

module "datalake_bronze_deposits_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment         = var.environment
  component           = "datalake"
  context             = join("-", compact(["bronze", "deposits"]))
  enable_versioning   = var.enable_versioning
  kms_key_arn         = var.kms_s3_arn
  object_lock_enabled = var.object_lock_enabled
}

module "datalake_silver_deposits_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = "datalake"
  context              = join("-", compact(["silver", "deposits"]))
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.datalake_silver_deposits_bucket.json
}

module "datalake_gold_deposits_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = "datalake"
  context              = join("-", compact(["gold", "deposits"]))
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.datalake_gold_deposits_bucket.json
}

module "datalake_bronze_accounts_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment         = var.environment
  component           = "datalake"
  context             = join("-", compact(["bronze", "accounts"]))
  enable_versioning   = var.enable_versioning
  kms_key_arn         = var.kms_s3_arn
  object_lock_enabled = var.object_lock_enabled
}

module "datalake_silver_accounts_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = "datalake"
  context              = join("-", compact(["silver", "accounts"]))
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.datalake_silver_accounts_bucket.json
}

module "datalake_gold_accounts_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = "datalake"
  context              = join("-", compact(["gold", "accounts"]))
  enable_versioning    = var.enable_versioning
  kms_key_arn          = var.kms_s3_arn
  object_lock_enabled  = var.object_lock_enabled
  extended_policy_json = data.aws_iam_policy_document.datalake_gold_accounts_bucket.json
}
