data "aws_route53_zone" "public" {
  count = var.enable_ui ? 1 : 0

  name         = "${var.public_domain_name}."
  private_zone = false
}

module "alb_prerequisites" {
  count = var.enable_ui ? 1 : 0

  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
  version = "1.1.0"

  environment                     = var.environment
  component                       = var.component
  context                         = "monitoring"
  region                          = var.region
  prefix                          = var.prefix
  vpc_id                          = var.vpc_id
  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
  public_zone_id                  = data.aws_route53_zone.public[0].id
  domain_names                    = ["*.observability.${var.public_domain_name}"]
  kms_s3_arn                      = var.waf_s3_logs_cmk_arn
  require_api_key                 = false
  max_payload_size_in_bytes       = 1048576

  allowed_source_ips = [
    {
      cidr_blocks = var.tm_monitoring_ingress_allowed_ip_ranges
      description = "Allowed IP ranges "
    }
  ]
}

module "alb_prerequisites_vault_core" {
  count = var.enable_vautl_ui ? 1 : 0

  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
  version = "1.1.0"

  environment                     = var.environment
  component                       = var.component
  context                         = "vault-core"
  region                          = var.region
  prefix                          = var.prefix
  vpc_id                          = var.vpc_id
  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
  public_zone_id                  = data.aws_route53_zone.public[0].id
  domain_names                    = ["*.${var.public_domain_name}"]
  kms_s3_arn                      = var.waf_s3_logs_cmk_arn
  require_api_key                 = false
  max_payload_size_in_bytes       = 2097152

  allowed_source_ips = [
    {
      cidr_blocks = var.tm_vault_core_ingress_allowed_ip_ranges
      description = "Allowed IP ranges"
    }
  ]
}
