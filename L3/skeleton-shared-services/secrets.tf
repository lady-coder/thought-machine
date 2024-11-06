module "tm_api_secret" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secretsmanager_cmk_arn = var.kms_secrets_manager_arn
  secret_names = [
    "/tm-prefix/tm-api-key",
  ]
}
