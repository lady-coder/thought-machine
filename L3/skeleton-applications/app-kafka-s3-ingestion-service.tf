locals {
  arns_as_string = join(", ", [for bucket_name in var.s3_bronze_bucket_names : "arn:aws:s3:::${bucket_name}, arn:aws:s3:::${bucket_name}/*"])
  arns_as_list   = split(", ", local.arns_as_string)
}

module "kafka_s3_ingestion_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.1.1"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  inline_policy                   = data.aws_iam_policy_document.s3_permissions.json
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "kafka-s3-ingestion-service"
  application_name = "kafka-s3-ingestion-service"

}

resource "aws_iam_role_policy_attachment" "kafka_s3_ingestion_service_appmesh_envoy" {
  role       = module.kafka_s3_ingestion_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "kafka_s3_ingestion_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.kafka_s3_ingestion_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "kafka-s3-ingestion-service"
  readwrite_topics = [
    "customers.customer.snapshot.v*",
    "customers.address.snapshot.v*",
  ]
}

data "aws_iam_policy_document" "s3_permissions" {
  statement {
    sid    = "BronzeBucketsReadUpdate"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectTagging",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]
    resources = local.arns_as_list
  }
}