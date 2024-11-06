
module "microservices_secrets" {
  source  = "spacelift.io/gft-blx/secrets-manager/aws"
  version = "1.0.1"

  secretsmanager_cmk_arn = var.secretsmanager_cmk_arn
  secret_names = [
    "/${var.environment}/${var.component}/digibank/customers/customer-cbs-service/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/customers/customer-iam-gateway/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/customers/customer-iam-gateway/pingone-token",
    "/${var.environment}/${var.component}/digibank/customers/customer-iam-service/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/customers/temporal/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/customers/twilio-otp-gateway/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/deposits/deposit-account-service/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/deposits/deposit-balance-service/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/deposits/deposit-portfolio-service/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/deposits/deposit-transfer-service/microservice-secrets",
    "/${var.environment}/${var.component}/digibank/deposits/statement-service/microservice-secrets"
  ]
}
