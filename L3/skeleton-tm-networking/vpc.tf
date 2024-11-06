module "vpc" {
  source  = "spacelift.io/gft-blx/tm-prime-vpc/aws"
  version = "1.0.0"

  region              = var.region
  environment         = var.environment
  component           = var.component
  domain              = var.domain
  subdomain           = var.subdomain
  cidr_block          = var.cidr_block
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  private_api_subnets = var.private_api_subnets
  msk_subnets         = var.msk_subnets
  db_subnets          = var.db_subnets
  endpoints_subnets   = var.endpoints_subnets
  number_of_nats      = var.number_of_nats
  eip_allocation_ids  = var.eip_allocation_ids
  kms_s3              = var.kms_s3_arn
}
