data "aws_route53_zone" "public" {
  count = var.enable_ui ? 1 : 0

  name         = "${var.public_domain_name}."
  private_zone = false
}

module "alb_prerequisites" {
  count = var.enable_ui ? 1 : 0

  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
  version = "1.1.0"

  environment = var.environment
  component   = var.component
  context     = "argocd"
  region      = var.region
  prefix      = var.prefix

  vpc_id                          = var.vpc_id
  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
  public_zone_id                  = data.aws_route53_zone.public[0].id
  domain_names                    = ["argocd.${var.public_domain_name}"]
  kms_s3_arn                      = var.waf_s3_logs_cmk_arn
  require_api_key                 = false

  allowed_source_ips = [
    {
      cidr_blocks = var.argocd_ingress_allowed_ip_ranges
      description = "Allowed IP ranges"
    }
  ]
}
