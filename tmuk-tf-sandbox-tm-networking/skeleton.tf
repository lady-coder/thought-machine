module "main" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"  
  source  = "spacelift.io/gft-blx/skeleton-tm-networking/aws"
  version = "1.0.0"

  environment = var.environment
  region      = var.region
  component   = var.component
  domain      = var.domain
  subdomain   = var.subdomain

  cidr_block          = "172.21.0.0/16"
  public_subnets      = ["172.21.0.0/26", "172.21.0.64/26", "172.21.0.128/26"]
  private_api_subnets = ["172.21.1.0/26", "172.21.1.64/26", "172.21.1.128/26"]
  # msk_subnets         = ["172.21.2.0/27", "172.21.2.32/27", "172.21.2.64/27"] #NOTE: by default the subnets disabled
  db_subnets        = ["172.21.2.96/27", "172.21.2.128/27", "172.21.2.160/27"]
  endpoints_subnets = ["172.21.2.192/27", "172.21.2.224/27", "172.21.3.0/27"]
  private_subnets   = ["172.21.64.0/18", "172.21.128.0/18", "172.21.192.0/18"]
  number_of_nats    = 1

  kms_s3_arn         = module.kms.kms_s3_arn
  kms_ebs_arn        = module.kms.kms_ebs_arn
  kms_cloudwatch_arn = module.kms.kms_cloudwatch_arn

  eip_allocation_ids          = values(aws_eip.this)[*].allocation_id
  spacelift_ec2_ami_id        = var.spacelift_ec2_ami_id
  spacelift_ec2_instance_type = var.spacelift_ec2_instance_type
}
