data "aws_caller_identity" "current" {}

module "kms_ebs" {
  source             = "spacelift.io/gft-blx/kms/aws"
  version            = "1.0.2"
  account_name       = "${var.environment}-default"
  service_name       = "ebs"
  services_principal = ["ec2.${var.region}.amazonaws.com"]
}

module "kms_s3" {
  source             = "spacelift.io/gft-blx/kms/aws"
  version            = "1.0.2"
  account_name       = "${var.environment}-flowlog"
  service_name       = "s3"
  services_principal = ["s3.${var.region}.amazonaws.com"]
}

module "kms_xray" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name = "${var.environment}-default"
  service_name = "xray"
}

module "kms_cloudwatch" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.2"

  account_name = "${var.environment}-spacelift"
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

module "kms_lambda" {
  source  = "spacelift.io/gft-blx/kms/aws"
  version = "1.0.1"

  account_name       = "${var.environment}-lambda"
  service_name       = "lambda"
  services_principal = ["lambda.${var.region}.amazonaws.com"]
}
