
module "waf_log_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.8"

  environment          = var.environment
  component            = var.component
  context              = var.context
  prefix               = local.s3_bucket_prefix # Required, see https://docs.aws.amazon.com/waf/latest/developerguide/logging-s3.html
  kms_key_arn          = var.kms_s3_arn
  extended_policy_json = data.aws_iam_policy_document.waf_log_bucket.json
}
