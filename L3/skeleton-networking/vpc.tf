module "vpc" {
  source  = "spacelift.io/gft-blx/default-vpc/aws"
  version = "2.1.16"

  region             = var.region
  environment        = var.environment
  component          = var.component
  domain             = var.domain
  prefix             = var.prefix
  enable_nat_gateway = true
  single_nat_gateway = true

  cidr_block           = var.cidr_block
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  protected_subnets    = var.protected_subnets
  tgw_subnets          = var.tgw_subnets
  eip_allocation_ids   = var.eip_allocation_ids
  kms_s3               = var.kms_s3_arn
  enabled_vpc_endpoint = var.enabled_vpc_endpoint
}
