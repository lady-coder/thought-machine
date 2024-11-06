
# ArgoCD Github App secret
module "argocd_github_app_secret" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names           = ["/${var.environment}/${var.component}/platform/argocd/github-app-private-key"]
  secretsmanager_cmk_arn = module.kms_platform_secrets.kms_key_arn
}

# Github Action Github App secret
module "github_action_github_app_secret" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names           = ["/${var.environment}/${var.component}/platform/github-action/github-app-private-key"]
  secretsmanager_cmk_arn = module.kms_platform_secrets.kms_key_arn
}

# Deprecated - To be destroyed
module "argocd_github_token" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names           = ["/${var.environment}/${var.component}/platform/argocd/github-token"]
  secretsmanager_cmk_arn = module.kms_platform_secrets.kms_key_arn
}

module "apollo_server_api_key" {
  count = var.create_apollo_api_key_secret ? 1 : 0

  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names           = ["/${var.environment}/${var.component}/digibank/apollo/api-key"]
  secretsmanager_cmk_arn = module.kms_platform_secrets.kms_key_arn
}

module "appmesh_certificate_secrets" {
  count = var.create_appmesh_certificate_secrets ? 1 : 0

  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names = [
    "/${var.environment}/${var.component}/platform/appmesh/ca",
    "/${var.environment}/${var.component}/platform/appmesh/root-ca-bundle"
  ]
  secretsmanager_cmk_arn = module.kms_platform_secrets.kms_key_arn
}

module "microservices_api_key_secrets" {
  count = var.create_microservices_api_key_secret ? 1 : 0

  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secret_names           = ["/${var.environment}/${var.component}/digibank/microservices/api-key"]
  secretsmanager_cmk_arn = module.kms_platform_secrets.kms_key_arn
}
