module "apollo_alb_prerequisites" {
  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
  version = "1.0.4"

  environment = var.environment
  component   = var.component
  context     = "apollo"
  region      = var.region

  vpc_id                          = var.vpc_id
  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
  public_zone_id                  = data.aws_route53_zone.public.id
  domain_names                    = ["gql.${var.public_domain_name}"]
  kms_s3_arn                      = var.s3_cmk_arn
  require_api_key                 = true
  api_key                         = data.aws_secretsmanager_secret_version.apollo_api_key.secret_string

  allowed_source_ips = [
    {
      cidr_blocks = var.apollo_ingress_allowed_ip_ranges
      description = "Allowed IP ranges"
    }
  ]
}

module "apollo_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "2.2.2"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn

  scope            = "${var.environment}-${var.component}"
  namespace        = "apollo"
  application_name = "apollo"

}

resource "aws_iam_role_policy_attachment" "apollo_appmesh_envoy" {
  role       = module.apollo_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}
