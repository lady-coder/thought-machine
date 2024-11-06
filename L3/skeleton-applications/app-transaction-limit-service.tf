
module "transaction_limit_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "transaction-limit-service"
  application_name = "transaction-limit-service"

}

resource "aws_iam_role_policy_attachment" "transaction_limit_service_appmesh_envoy" {
  role       = module.transaction_limit_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "transaction_limit_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.transaction_limit_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "transaction-limit-service"
  readwrite_topics = [
    "deposits.customer.limit.update.completed.v*",
    "deposits.sme.limit.update.completed.v*",
    "shared.notification.push-request.v*",
  ]
}

data "aws_iam_policy_document" "transaction_limit_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/transaction_limit_service_iam_user"]
  }
}

resource "aws_iam_role_policy" "transaction_limit_service_aurora" {
  name   = "transaction-limit-service-aurora"
  policy = data.aws_iam_policy_document.transaction_limit_service_aurora.json
  role   = module.transaction_limit_service_irsa_role.irsa_role_name
}
