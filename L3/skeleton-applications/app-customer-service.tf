
# uncomment before deploying an ingress
#module "customer_service_alb_prerequisites" {
#  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
#  version = "1.0.6"
#
#  environment = var.environment
#  component   = var.component
#  context     = "customer-service"
#  region      = var.region
#
#  vpc_id                          = var.vpc_id
#  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
#  public_zone_id                  = data.aws_route53_zone.public.id
#  domain_names                    = ["cms.${var.public_domain_name}"]
#  kms_s3_arn                      = var.s3_cmk_arn
#  require_api_key                 = true
#  api_key                         = data.aws_secretsmanager_secret_version.microservices_api_key.secret_string
#
#  allowed_source_ips = [
#    {
#      cidr_blocks = var.microservices_ingress_allowed_ip_ranges
#      description = "Allowed IP ranges"
#    }
#  ]
#}

module "customer_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "customer-service"
  application_name = "customer-service"

}

resource "aws_iam_role_policy_attachment" "customer_service_appmesh_envoy" {
  role       = module.customer_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "customer_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.customer_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "customer-service"
  readwrite_topics = [
    "customer.customer-service.checklist-step-update.v*",
    "customers.accepted_document.snapshot.v*",
    "customers.address.snapshot.v*",
    "customers.customer.snapshot.v*",
    "customers.customer_status.snapshot.v*",
    "customers.employment.snapshot.v*",
    "customers.identity_verification.snapshot.v*",
    "customers.profile.snapshot.v*",
    "customers.sme.snapshot.v*",
    "customers.sme_customer.snapshot.v*",
    "customers.sme_profile.snapshot.v*",
    "deposit.saving-account.created.v*",
    "financing-zoral.account.snapshot.v*",
    "onboarding.customer-identity-service.ekyc-response.v*",
    "onboarding.customer-identity-service.ekyc-result.v*",
    "onboarding.customer-identity-service.sme-ekyc-response.v*",
    "onboarding.customer-overall-status.v*",
    "onboarding.customer-service.archive-customer.v*",
    "onboarding.customer-service.customer-devices-status.v*",
    "onboarding.customer-service.customer-personal-details-stored.v*",
    "onboarding.customer-service.customer-personal-details.v*",
    "onboarding.customer-service.customer-savings-account-created.v*",
    "onboarding.customer-service.customer-status.v*",
    "onboarding.customer-service.participation-sme-customers.v*",
    "onboarding.customer-service.sme-status.v*",
    "onboarding.iam-account.created.v*",
    "onboarding.onboarding-service.offboarding-finished.v*",
    "onboarding.onboarding-service.offboarding-request.v*",
    "onboarding.payments-service.initial-payment-verifications.v*",
    "payments.proxy.auto.deregistration.completed.v*",
    "shared.notification.silent-push-request.v*",
  ]
}

data "aws_iam_policy_document" "customer_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/customers_iam_user"]
  }
}

resource "aws_iam_role_policy" "customer_service_aurora" {
  name   = "customer-service-aurora"
  policy = data.aws_iam_policy_document.customer_service_aurora.json
  role   = module.customer_service_irsa_role.irsa_role_name
}
