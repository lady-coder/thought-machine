module "kms" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"  
  source  = "spacelift.io/gft-blx/kms-networking/aws"
  version = "1.0.0"

  environment = var.environment
  region      = var.region

  L4_tags = var.L4_tags
}
