
module "statement_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "statement-service"
  application_name = "statement-service"

}

resource "aws_iam_role_policy_attachment" "statement_service_appmesh_envoy" {
  role       = module.statement_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "statement_service_bucket" {
  source  = "spacelift.io/gft-blx/s3-private/aws"
  version = "1.2.7"

  environment         = var.environment
  component           = var.component
  context             = "statement-service"
  enable_versioning   = true
  kms_key_arn         = var.s3_cmk_arn
  object_lock_enabled = true
}

data "aws_iam_policy_document" "statement_service_bucket_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts"
    ]
    resources = [
      "${module.statement_service_bucket.bucket_arn}/*",
      "${module.statement_service_bucket.bucket_arn}/",
      module.statement_service_bucket.bucket_arn
    ]
  }
}

resource "aws_iam_policy" "statement_service_bucket_policy" {
  name   = "${var.environment}-${var.component}-statement-service-policy"
  policy = data.aws_iam_policy_document.statement_service_bucket_policy.json
}

resource "aws_iam_role_policy_attachment" "statement_service_bucket_policy" {
  role       = module.statement_service_irsa_role.irsa_role_name
  policy_arn = aws_iam_policy.statement_service_bucket_policy.arn
}

module "statement_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.statement_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "statement-service"
  readwrite_topics = [
    "deposit-account-service.current-account.snapshot.v*",
    "deposit-account-service.saving-account.snapshot.v*",
    "deposit-sme-account-service.current-account.snapshot.v*",
    "financing-account-service.account.snapshot.v*",
    "pfm.statement-service.create-financing-statement-command.v*",
    "pfm.statement-service.create-statement-command.v*",
    "shared.notification.push-request.v*",
    "statement-service.sme-create-statement-command.v*",
  ]
}

data "aws_iam_policy_document" "statement_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/statement_service_iam_user"]
  }
}

resource "aws_iam_role_policy" "statement_service_aurora" {
  name   = "statement-service-aurora"
  policy = data.aws_iam_policy_document.statement_service_aurora.json
  role   = module.statement_service_irsa_role.irsa_role_name
}
