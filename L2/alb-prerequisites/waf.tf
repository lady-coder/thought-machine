module "waf" {
  source  = "spacelift.io/gft-blx/waf/aws"
  version = "1.1.0"

  component   = var.component
  context     = var.context
  environment = var.environment
  region      = var.region
  prefix      = var.prefix

  api_key         = var.api_key
  require_api_key = var.require_api_key

  ip_rate_based_limit_per_5min        = var.ip_rate_based_limit_per_5min
  max_payload_size_in_bytes           = var.max_payload_size_in_bytes
  managed_rules_common_rules_excluded = var.managed_rules_common_rules_excluded
  managed_rules_linux_rules_excluded  = var.managed_rules_linux_rules_excluded
  blocked_countries                   = var.blocked_countries
  allowed_paths                       = var.allowed_paths

  kms_s3_arn = var.kms_s3_arn
}
