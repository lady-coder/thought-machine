module "kms_ecr" {
  source             = "spacelift.io/gft-blx/kms/aws"
  version            = "1.0.3"
  account_name       = "${var.environment}-spacelift"
  service_name       = "ecr"
  services_principal = ["ecr.${var.region}.amazonaws.com"]
}
