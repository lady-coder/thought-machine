resource "aws_eip" "this" {
  domain = "vpc"
  tags = {
    "Name" = "${var.environment}-${var.component}-ngw-eip"
  }
}

module "vpc" {
  source = "./modules/vpc"

  region      = var.region
  environment = var.environment
  component   = var.component

  cidr_block      = var.cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpce_subnets    = var.vpce_subnets

  eip_allocation_id = aws_eip.this.allocation_id
}

module "kms_cloudwatch" {
  source = "./modules/kms"

  account_name = "${var.environment}-${var.component}"
  service_name = "cloudwatch"

  service_principals_with_general_conditions = [
    {
      svc_identifiers = ["logs.${var.region}.amazonaws.com"]
      condition = [
        {
          test     = "ArnEquals"
          values   = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:*"]
          variable = "kms:EncryptionContext:aws:logs:arn"
        }
      ]
    }
  ]
}

module "kms_ecr" {
  source = "./modules/kms"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "ecr"
  services_principal = ["ecr.${var.region}.amazonaws.com"]
}

module "kms_s3" {
  source = "./modules/kms"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "s3"
  services_principal = ["s3.${var.region}.amazonaws.com"]
}

module "kms_secrets_manager" {
  source = "./modules/kms"

  account_name       = "${var.environment}-${var.component}"
  service_name       = "secrets-manager"
  services_principal = ["secretsmanager.${var.region}.amazonaws.com"]
}

module "tm_secrets" {
  source = "./modules/secrets-manager"

  secret_names           = ["tm-sync-token"]
  secretsmanager_cmk_arn = module.kms_secrets_manager.kms_alias_arn
}

module "s3_artifacts" {
  source = "./modules/s3-private"

  environment = var.environment
  component   = var.component
  context     = "pipeline"
  kms_key_arn = module.kms_s3.kms_alias_arn
}

module "codecommit_sync_image" {
  source = "./modules/codecommit"

  environment = var.environment
  component   = var.component
  context     = "images"
}

module "codebuild_sync_image" {
  source = "./modules/codebuild"

  region                      = var.region
  environment                 = var.environment
  component                   = var.component
  context                     = "images"
  phase                       = "build"
  vpc_id                      = module.vpc.vpc_id
  vpc_subnets                 = module.vpc.private_subnets_ids
  kms_key_arn                 = module.kms_s3.kms_alias_arn
  s3_artifacts                = module.s3_artifacts.bucket_arn
  cloudwatch_kms_arn          = module.kms_cloudwatch.kms_alias_arn
  codecommit_repository_name  = module.codecommit_sync_image.repository_name
  codebuild_access_secret_arn = module.tm_secrets.secret_arns[0]

  environment_variables = [
    {
      name  = "S3_ARTIFACTS"
      value = "s3://${module.s3_artifacts.bucket_id}"
    },
    {
      name  = "ECR_KMS_ARN"
      value = module.kms_ecr.kms_alias_arn
    }
  ]
}

module "codebuild_verify_image" {
  source = "./modules/codebuild"

  region                      = var.region
  environment                 = var.environment
  component                   = var.component
  context                     = "images"
  phase                       = "verify"
  vpc_id                      = module.vpc.vpc_id
  vpc_subnets                 = module.vpc.private_subnets_ids
  kms_key_arn                 = module.kms_s3.kms_alias_arn
  s3_artifacts                = module.s3_artifacts.bucket_arn
  cloudwatch_kms_arn          = module.kms_cloudwatch.kms_alias_arn
  codecommit_repository_name  = module.codecommit_sync_image.repository_name
  codebuild_access_secret_arn = module.tm_secrets.secret_arns[0]

  environment_variables = [
    {
      name  = "S3_ARTIFACTS"
      value = "s3://${module.s3_artifacts.bucket_id}"
    }
  ]
}

module "codepipeline_sync_image" {
  source = "./modules/codepipeline"

  region             = var.region
  environment        = var.environment
  component          = var.component
  context            = "images"
  source_repo_name   = module.codecommit_sync_image.repository_name
  source_repo_branch = "main"
  s3_artifacts       = module.s3_artifacts.bucket_id
  kms_key_arn        = module.kms_s3.kms_alias_arn
  stages             = var.pipeline_stages
}
