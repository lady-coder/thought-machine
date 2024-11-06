module "kms_platform_secrets" {
  source             = "spacelift.io/gft-blx/kms/aws"
  version            = "1.0.3"
  account_name       = "${var.environment}-${var.component}"
  service_name       = "platform-secrets"
  services_principal = ["secretsmanager.${var.region}.amazonaws.com"]
}
