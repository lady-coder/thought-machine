module "spacelift_ecr" {
  source  = "spacelift.io/gft-blx/ecr/aws"
  version = "2.0.1"

  region           = var.region
  ecr_repositories = var.spacelift_repositories
  kms_cmk_ecr      = module.kms_ecr.kms_key_arn

  ecr_iam_principal = var.ecr_iam_principal
  readonly_external_aws_iam_principals = [
    "arn:aws:iam::336241431902:root", # Shared Service
    "arn:aws:iam::079962189452:root", # Uk extension account
    "arn:aws:iam::198698840116:root", # Sandbox Apps
    "arn:aws:iam::051939627954:root", # UK Sandbox account
    "arn:aws:iam::304319179974:root"  # Sandbox TM
  ]
}

module "platform_ecr" {
  source  = "spacelift.io/gft-blx/ecr/aws"
  version = "2.0.1"

  region           = var.region
  ecr_repositories = var.platform_repositories
  kms_cmk_ecr      = module.kms_ecr.kms_key_arn

  ecr_iam_principal = var.ecr_iam_principal
  readonly_external_aws_iam_principals = [
    "arn:aws:iam::336241431902:root", # Shared Service
    "arn:aws:iam::079962189452:root", # Uk extension account
    "arn:aws:iam::198698840116:root", # Sandbox Apps
    "arn:aws:iam::051939627954:root", # UK Sandbox account
    "arn:aws:iam::304319179974:root"  # Sandbox TM
  ]
}
