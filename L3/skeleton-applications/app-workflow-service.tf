
module "workflow_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "workflow-service"
  application_name = "workflow-service"

}

resource "aws_iam_role_policy_attachment" "workflow_service_appmesh_envoy" {
  role       = module.workflow_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "workflow_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.workflow_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "workflow-service"
  readwrite_topics = [
    "deposit.deposit-portfolio-service.portfolio-created.v*",
    "deposit.deposit-portfolio-service.portfolio-linked-with-account.v*",
    "deposit.saving-account.created.v*",
    "deposit.saving-account.inactivated.v*",
    "saving-account-creation-queue*",
  ]
}
