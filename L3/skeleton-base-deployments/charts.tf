module "external_secrets" {
  source  = "spacelift.io/gft-blx/helm-external-secrets/aws"
  version = "1.4.2"

  environment = var.environment
  region_ecr  = var.region_ecr
  component   = var.component

  irsa_role_arn       = module.external_secrets_iam_service_role.irsa_role_arn
  node_group_role_arn = module.eks_node_group.iam_role_arn

  shared_services_account_id = var.shared_services_account_id
  external_secrets_version   = var.external_secrets_version

  depends_on = [module.eks_node_group]
}

module "argocd" {
  source  = "spacelift.io/gft-blx/helm-argocd/aws"
  version = "2.5.6"

  region      = var.region
  environment = var.environment
  component   = var.component
  prefix      = var.prefix
  region_ecr  = var.region_ecr

  github_org_url             = var.github_org_url
  github_oauth_app_client_id = var.argocd_github_oauth_app_client_id
  github_app_id              = var.argocd_github_app_id
  github_app_installation_id = var.argocd_github_app_installation_id
  enable_ui                  = var.enable_ui
  redis_version              = var.redis_version
  argocd_version             = var.argocd_version

  platform_base_role_arns_map = values(module.platform_base_irsa_roles)[*].irsa_application_name_to_arn_mapping
  platform_env_role_arns_map  = values(module.platform_env_dedicated_irsa_roles)[*].irsa_application_name_to_arn_mapping
  external_secrets_namespace  = module.external_secrets.namespace
  shared_services_account_id  = var.shared_services_account_id

  vpc_id                           = var.vpc_id
  eks_workers_subnet_cidrs         = var.eks_workers_subnet_cidrs
  public_domain_name               = var.public_domain_name
  waf_s3_logs_cmk_arn              = var.waf_s3_logs_cmk_arn
  argocd_ingress_allowed_ip_ranges = var.argocd_ingress_allowed_ip_ranges
  public_subnet_ids                = var.public_subnet_ids
  approvers_repository_access      = var.approvers_repository_access

  depends_on = [module.external_secrets]
}

module "applications-infrastructure" {
  source  = "spacelift.io/gft-blx/helm-applications-infrastructure/aws"
  version = "1.2.0"

  environment                    = var.environment
  github_org_url                 = var.github_org_url
  platform_git_ops_repo_name     = var.platform_git_ops_repo_name
  applications_git_ops_repo_name = var.applications_git_ops_repo_name
  argocd_namespace               = module.argocd.namespace
  infrastructure_path            = var.infrastructure_path

  depends_on = [module.argocd]
}
