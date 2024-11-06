
module "deposit_portfolio_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "deposit-portfolio-service"
  application_name = "deposit-portfolio-service"

}

resource "aws_iam_role_policy_attachment" "deposit_portfolio_service_appmesh_envoy" {
  role       = module.deposit_portfolio_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "deposit_portfolio_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.deposit_portfolio_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "deposit-portfolio-service"
  readwrite_topics = [
    "deposit-portfolio-service.portfolio-link.snapshot.v*",
    "deposit-portfolio-service.portfolio.snapshot.v*",
    "deposit.deposit-portfolio-service.portfolio-created.v*",
    "deposit.deposit-portfolio-service.portfolio-linked-with-account.v*",
    "deposit.portfolio.account.unlinked.v*",
    "deposit.portfolio.closed.v*",
  ]
}

data "aws_iam_policy_document" "deposit_portfolio_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/deposit_portfolio_iam_user"]
  }
}

resource "aws_iam_role_policy" "deposit_portfolio_service_aurora" {
  name   = "deposit-portfolio-service-aurora"
  policy = data.aws_iam_policy_document.deposit_portfolio_service_aurora.json
  role   = module.deposit_portfolio_service_irsa_role.irsa_role_name
}
