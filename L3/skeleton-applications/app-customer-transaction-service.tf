module "customer_transaction_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "customer-transaction-service"
  application_name = "customer-transaction-service"
}

resource "aws_iam_role_policy_attachment" "customer_transaction_service_appmesh_envoy" {
  role       = module.customer_transaction_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "customer_transaction_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.customer_transaction_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "customer-transaction-service"
  readwrite_topics = [
    "shared.notification.push-request.v*",
    "onboarding.payments-service.initial-payment-verifications.v*",
    "customer.ftv.trigger.reversal.command.v*",
    "payments.transfer.inbound.initial.v*",
    "shared.email.bank.v*"
  ]
}

data "aws_iam_policy_document" "customer_transaction_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/customer_transaction_iam_user"]
  }
}

resource "aws_iam_role_policy" "customer_transaction_service_aurora" {
  name   = "customer-transaction-service-aurora"
  policy = data.aws_iam_policy_document.customer_transaction_service_aurora.json
  role   = module.customer_transaction_service_irsa_role.irsa_role_name
}
