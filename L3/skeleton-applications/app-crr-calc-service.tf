module "crr_calc_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "crr-calc-service"
  application_name = "crr-calc-service"
}

resource "aws_iam_role_policy_attachment" "crr_calc_service_appmesh_envoy" {
  role       = module.crr_calc_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "crr_calc_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.crr_calc_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "crr-calc-service"
  readwrite_topics = [
    "customers.address.snapshot.v*",
    "customers.customer.snapshot.v*",
    "customers.employment.snapshot.v*",
    "customers.sme_customer.snapshot.v*",
    "customers.sme_profile.snapshot.v*",
    "customers.sme.snapshot.v*",
    "financing-zoral.account.snapshot.v*",
    "framl.crr-calc-service.crr-calculation-trigger.v*",
    "framl.crr-calc-service.crr-calculation.v*",
    "framl.crr-calc-service.error-crr-calculation.v*",
    "framl.crr-calc-service.financing-crr-calculation.v*",
    "framl.crr-calc-service.financing-sme-crr-calculation.v*",
    "framl.crr-calc-service.first-crr-calculating.v*",
    "framl.crr-calc-service.sme-crr-calculation-trigger.v*",
    "framl.crr-calc-service.sme-crr-calculation.v*",
    "framl.crr-result.snapshot.v*",
    "framl.data-screening-service.turn-off-ca-monitor.v*",
    "framl.detailed_comply_advantage.snapshot.v*",
    "framl.manual-review-sme.snapshot.v*",
    "framl.sme_application_crr_result.snapshot.v*",
    "framl.sme_crr_result.snapshot.v*",
    "framl.sme_related_crr_result.snapshot.v*",
    "onboarding.onboarding-service.offboarding-cleared-steps.v*",
    "onboarding.onboarding-service.offboarding-request.v*",
  ]
}

data "aws_iam_policy_document" "crr_calc_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/customer_risk_rating_iam_user"]
  }
}

resource "aws_iam_role_policy" "crr_calc_service_aurora" {
  name   = "crr-calc-service-aurora"
  policy = data.aws_iam_policy_document.crr_calc_service_aurora.json
  role   = module.crr_calc_service_irsa_role.irsa_role_name
}
