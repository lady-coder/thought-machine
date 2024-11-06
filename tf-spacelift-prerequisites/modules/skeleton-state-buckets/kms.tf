module "kms_db" {
  source             = "spacelift.io/gft-blx/kms/aws"
  version            = "1.0.1"
  account_name       = "${var.environment}-tf-state"
  service_name       = "dynamodb"
  services_principal = ["dynamodb.${var.region}.amazonaws.com"]
}

module "kms_s3" {
  source             = "spacelift.io/gft-blx/kms/aws"
  version            = "1.0.1"
  account_name       = "${var.environment}-tf-state"
  service_name       = "s3"
  services_principal = ["s3.${var.region}.amazonaws.com"]
}
