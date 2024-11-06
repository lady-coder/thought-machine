
# uncomment before deploying an ingress
#module "deposit_account_service_alb_prerequisites" {
#  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
#  version = "1.0.6"
#
#  environment = var.environment
#  component   = var.component
#  context     = "dep-account-service"
#  region      = var.region
#
#  vpc_id                          = var.vpc_id
#  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
#  public_zone_id                  = data.aws_route53_zone.public.id
#  domain_names                    = ["dpas.${var.public_domain_name}"]
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

module "deposit_account_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "deposit-account-service"
  application_name = "deposit-account-service"

}

resource "aws_iam_role_policy_attachment" "deposit_account_service_appmesh_envoy" {
  role       = module.deposit_account_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "deposit_account_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.deposit_account_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "deposit-account-service"
  readwrite_topics = [
    "deposit-account-service.current-account.snapshot.v*",
    "deposit-account-service.saving-account.snapshot.v*",
    "deposit-account-service.saving-pot.snapshot.v*",
    "deposit.balance.updated.v*",
    "deposit.current-account.created.v*",
    "deposit.deposit-portfolio-service.portfolio-linked-with-account.v*",
    "deposit.portfolio.account.unlinked.v*",
    "deposit.saving-account.inactivated.v*",
    "deposit.saving-pot.created.v*",
    "deposits.customer.limit.update.completed.v*",
    "onboarding.onboarding-service.offboarding-changed-steps.v*",
    "onboarding.onboarding-service.offboarding-request.v*",
    "shared.notification.push-request.v*",
  ]
}

data "aws_iam_policy_document" "deposit_account_service_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/deposit_account_iam_user"]
  }
}

resource "aws_iam_role_policy" "deposit_account_service_aurora" {
  name   = "deposit-account-service-aurora"
  policy = data.aws_iam_policy_document.deposit_account_service_aurora.json
  role   = module.deposit_account_service_irsa_role.irsa_role_name
}
