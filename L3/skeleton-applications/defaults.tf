data "aws_caller_identity" "current" {}

data "aws_route53_zone" "public" {
  name         = "${var.public_domain_name}."
  private_zone = false
}

data "aws_secretsmanager_secret" "apollo_api_key" {
  name = "/${var.environment}/${var.component}/digibank/apollo/api-key"
}

data "aws_secretsmanager_secret_version" "apollo_api_key" {
  secret_id = data.aws_secretsmanager_secret.apollo_api_key.id
}

data "aws_secretsmanager_secret" "microservices_api_key" {
  name = "/${var.environment}/${var.component}/digibank/microservices/api-key"
}

data "aws_secretsmanager_secret_version" "microservices_api_key" {
  secret_id = data.aws_secretsmanager_secret.microservices_api_key.id
}

locals {
  msk_cluster_name = "${var.component}-kafka"
  account_id       = data.aws_caller_identity.current.account_id
}
