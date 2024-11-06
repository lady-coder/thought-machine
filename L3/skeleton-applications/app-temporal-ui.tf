module "temporal_ui_alb_prerequisites" {
  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
  version = "1.0.6"

  environment = var.environment
  component   = var.component
  context     = "temporal-ui"
  region      = var.region

  vpc_id                          = var.vpc_id
  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
  public_zone_id                  = data.aws_route53_zone.public.id
  domain_names                    = ["tprui.${var.public_domain_name}"]
  kms_s3_arn                      = var.s3_cmk_arn
  require_api_key                 = false

  allowed_source_ips = [
    {
      cidr_blocks = var.microservices_ingress_allowed_ip_ranges
      description = "Allowed IP ranges"
    }
  ]
}

module "temporal_ui_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = false

  scope            = "${var.environment}-${var.component}"
  namespace        = "temporal-ui"
  application_name = "temporal-ui"
}

resource "aws_iam_role_policy_attachment" "temporal_ui_appmesh_envoy" {
  role       = module.temporal_ui_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}
