module "tm_secrets" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secretsmanager_cmk_arn = var.secretsmanager_cmk_arn
  secret_names = [
    "${var.tm_iam_prefix}/${var.secret_prefix}/root-db-secrets"
  ]
}
