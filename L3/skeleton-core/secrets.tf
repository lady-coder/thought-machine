module "msk_platform_secrets" {
  count = length(var.msk_platform_secrets) > 0 ? 1 : 0

  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names           = var.msk_platform_secrets
  secretsmanager_cmk_arn = var.secretsmanager_cmk_arn
}
