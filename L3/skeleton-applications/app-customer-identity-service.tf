
module "customer_identity_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "customer-identity-service"
  application_name = "customer-identity-service"

}

resource "aws_iam_role_policy_attachment" "customer_identity_service_appmesh_envoy" {
  role       = module.customer_identity_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "customer_identity_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.customer_identity_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "customer-identity-service"
  readwrite_topics = [
    "onboarding.customer-identity-service.ekyc-response.v*",
    "onboarding.customer-identity-service.ekyc-result.v*",
    "onboarding.customer-identity-service.sme-ekyc-response.v*",
    "onboarding.customer-service.archive-customer.v*",
    "onboarding.customer-service.customer-status.v*",
    "shared.notification.push-request.v*",
    "shared.notification.silent-push-request.v*",
  ]
}

data "aws_iam_policy_document" "customer_identity_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/customer_identity_iam_user"]
  }
}

resource "aws_iam_role_policy" "customer_identity_service_aurora" {
  name   = "customer-identity-service-aurora"
  policy = data.aws_iam_policy_document.customer_identity_service_aurora.json
  role   = module.customer_identity_service_irsa_role.irsa_role_name
}
