module "flow_log_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = var.component
  context              = "flow-logs"
  kms_key_arn          = var.kms_s3
  extended_policy_json = data.aws_iam_policy_document.log_bucket.json
}
