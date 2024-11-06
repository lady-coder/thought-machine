data "aws_caller_identity" "current" {}

module "kms_eks" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "eks"
  services_principal = ["eks.${var.region}.amazonaws.com"]
}

module "kms_s3_eks" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-eks"
  service_name       = "s3"
  services_principal = ["s3.${var.region}.amazonaws.com"]
}

module "kms_sns" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name            = "${var.environment}-${var.component}"
  service_name            = "sns"
  services_principal      = ["sns.${var.region}.amazonaws.com"]
  enable_cloudwatch_alarm = true
}

module "kms_cloudwatch" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name = "${var.environment}-${var.component}"
  service_name = "cloudwatch"

  service_principals_with_general_conditions = [
    {
      svc_identifiers = ["logs.${var.region}.amazonaws.com"]
      condition = [
        {
          test     = "ArnEquals"
          values   = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:*"]
          variable = "kms:EncryptionContext:aws:logs:arn"
        }
      ]
    }
  ]
}

module "kms_aurora" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "aurora"
  services_principal = ["rds.${var.region}.amazonaws.com"]
}

module "kms_msk" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "msk"
  services_principal = ["kafka.${var.region}.amazonaws.com"]
}

module "kms_ssm" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "ssm"
  services_principal = ["ssm.${var.region}.amazonaws.com"]
}

module "kms_secrets_manager" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "secrets-manager"
  services_principal = ["secretsmanager.${var.region}.amazonaws.com"]
}

module "kms_lambda" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "lambda"
  services_principal = ["lambda.${var.region}.amazonaws.com"]
}
