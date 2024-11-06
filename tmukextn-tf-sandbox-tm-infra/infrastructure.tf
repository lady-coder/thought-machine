module "tm_kms_infra" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source  = "spacelift.io/gft-blx/kms-tm/aws"
  version = "1.0.1"

  environment = var.environment
  region      = var.region
  component   = var.component
}

module "tm_kubernetes_infra" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source  = "spacelift.io/gft-blx/skeleton-kubernetes/aws"
  version = "2.2.19"

  environment = var.environment
  region      = var.region
  component   = var.component

  vpc_id     = var.vpc_id
  vpc_cidr   = var.vpc_cidr
  subnet_ids = var.private_subnet_ids

  kubernetes_version = var.kubernetes_cluster_version
  kubectl_version    = var.kubectl_version

  cluster_encryption_cmk_arn           = module.tm_kms_infra.kms_eks_arn
  container_insights_log_group_cmk_arn = module.tm_kms_infra.kms_cloudwatch_arn
  sns_cmk_arn                          = module.tm_kms_infra.kms_sns_arn
  eks_s3_cmk_arn                       = module.tm_kms_infra.kms_s3_eks

  kms_cloudwatch_arn      = module.tm_kms_infra.kms_cloudwatch_arn
  kms_lambda_arn          = module.tm_kms_infra.kms_lambda_arn
  eks_jumphost_ec2_ami_id = var.eks_jumphost_ec2_ami_id

  container_insights_logs_retention_in_days    = var.container_insights_logs_retention_in_days
  container_insights_metrics_retention_in_days = var.container_insights_metrics_retention_in_days
  k8s_logs_alert_medium_treshold_5minutes      = var.k8s_logs_alert_medium_treshold_5minutes
  k8s_logs_alert_high_treshold_5minutes        = var.k8s_logs_alert_high_treshold_5minutes
  k8s_logs_alert_superhigh_treshold_5minutes   = var.k8s_logs_alert_superhigh_treshold_5minutes

  downscale_jumphost_after_working_hours = var.downscale_jumphost_after_working_hours
  working_hours_end_cron                 = var.working_hours_end_cron
  working_hours_start_cron               = var.working_hours_start_cron
}

module "tm_kubernetes_base_deployments" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source  = "spacelift.io/gft-blx/skeleton-base-deployments/aws"
  version = "1.14.9"

  aws_admin_role_name                 = var.aws_admin_role_name
  environment                         = var.environment
  region                              = var.region
  component                           = var.component
  prefix                              = var.prefix
  region_ecr                          = var.region_ecr
  eks_cluster_certificate_authority   = module.tm_kubernetes_infra.eks_cluster_certificate_authority
  eks_cluster_endpoint                = module.tm_kubernetes_infra.eks_cluster_endpoint
  eks_cluster_id                      = module.tm_kubernetes_infra.eks_cluster_id
  eks_cluster_name                    = module.tm_kubernetes_infra.eks_cluster_name
  eks_control_plane_security_group_id = module.tm_kubernetes_infra.eks_control_plane_security_group_id
  iam_openid_connect_provider_arn     = module.tm_kubernetes_infra.iam_openid_connect_provider_arn
  iam_openid_connect_provider_url     = module.tm_kubernetes_infra.iam_openid_connect_provider_url
  admin_jumphost_iam_role_name        = module.tm_kubernetes_infra.admin_jumphost_iam_role_name
  shared_services_account_id          = var.shared_services_account_id
  external_secrets_version            = var.external_secrets_version
  github_org_url                      = var.github_org_url
  platform_git_ops_repo_name          = var.platform_git_ops_repo_name
  applications_git_ops_repo_name      = var.applications_git_ops_repo_name
  //github_pat_owner_username      = var.github_pat_owner_username
  //argocd_github_app_client_id    = var.argocd_github_app_client_id
  argocd_github_app_id              = var.argocd_github_app_id
  argocd_github_app_installation_id = var.argocd_github_app_installation_id
  argocd_github_oauth_app_client_id = var.argocd_github_oauth_app_client_id
  argocd_version                    = var.argocd_version
  redis_version                     = var.redis_version
  enable_ui                         = true

  kubernetes_version = var.kubernetes_nodegroups_version

  vpc_id                           = var.vpc_id
  eks_workers_subnet_cidrs         = var.eks_workers_subnet_cidrs
  public_domain_name               = var.public_domain_name
  waf_s3_logs_cmk_arn              = module.tm_kms_infra.kms_s3_eks
  argocd_ingress_allowed_ip_ranges = var.argocd_ingress_allowed_ip_ranges
  public_subnet_ids                = var.public_subnet_ids
  approvers_repository_access      = var.approvers_repository_access

  node_groups = {

    business = {
      disk_size                     = 50
      instance_types                = ["t2.2xlarge", "t3a.2xlarge", "t3.2xlarge", "m4.2xlarge", "m5.2xlarge", "m5a.2xlarge", "m6a.2xlarge", "m6i.2xlarge"]
      capacity_type                 = "SPOT"
      subnet_ids                    = var.private_subnet_ids
      desired_capacity              = 7
      max_size                      = 12
      min_size                      = 0
      kubernetes_taints             = []
      downscale_after_working_hours = true
      downscale_start_cron          = var.working_hours_end_cron
      downscale_end_cron            = var.working_hours_start_cron
      downscale_schedule_cron       = var.working_hours_end_cron
      upscale_schedule_cron         = var.working_hours_start_cron
    }
    system = {
      disk_size                     = 50
      instance_types                = ["t3a.medium", "t3.medium", "t2.medium"]
      capacity_type                 = "SPOT"
      subnet_ids                    = var.private_subnet_ids
      desired_capacity              = 3
      max_size                      = 6
      min_size                      = 2
      downscale_after_working_hours = false
      downscale_start_cron          = var.working_hours_end_cron
      downscale_end_cron            = var.working_hours_start_cron
      downscale_schedule_cron       = var.working_hours_end_cron
      upscale_schedule_cron         = var.working_hours_start_cron
      kubernetes_taints = [
        {
          key    = "node-group"
          value  = "system"
          effect = "NO_EXECUTE"
        }
      ]
    }
  }

  env_dedicated_irsa_roles = {
    external-dns-public = {
      namespace : "external-dns-public"
      application_name : "external-dns-public"
      inline_policy : data.aws_iam_policy_document.external_dns.json
      policy_arns : []
    }
    external-dns-private = {
      namespace : "external-dns-private"
      application_name : "external-dns-private"
      inline_policy : data.aws_iam_policy_document.external_dns.json
      policy_arns : []
    }
    aws-load-balancer-controller = {
      namespace : "aws-load-balancer-controller"
      application_name : "aws-load-balancer-controller"
      inline_policy : data.aws_iam_policy_document.aws_load_balancer_controller.json
      policy_arns : []
    }

    aws-ebs-csi-driver = {
      namespace : "aws-ebs-csi-driver"
      application_name : "aws-ebs-csi-driver"
      inline_policy : ""
      policy_arns : ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
    }

    secrets-store-csi-driver = {
      namespace : "secrets-store-csi-driver"
      application_name : "secrets-store-csi-driver"
      inline_policy : data.aws_iam_policy_document.secrets-store-csi-driver.json
      policy_arns : []
    }
  }
}

module "tm_core_infra" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source  = "spacelift.io/gft-blx/skeleton-core/aws"
  version = "1.1.37"

  environment = var.environment
  region      = var.region
  component   = var.component

  vpc_id = var.vpc_id

  deploy_msk_in_public                   = false
  enable_msk_configuration_public_access = false
  enable_msk_configuration_for_tm        = true
  whitelisted_public_ingress_cidr_ranges = var.whitelisted_public_ingress_cidr_ranges
  kafka_subnet_ids                       = var.public_subnet_ids

  apps_jumphost_security_group_id = module.tm_kubernetes_infra.eks_jumphost_admin_security_group_id
  msk_platform_secrets            = []
  enable_broker_logs_export       = var.enable_broker_logs_export
  kafka_broker_instance_type      = var.kafka_broker_instance_type
  kafka_client_authentication = {
    iam   = var.kafka_client_authentication.iam
    scram = var.kafka_client_authentication.scram
  }

  aurora_subnet_ids            = var.db_subnet_ids
  aurora_instance_class        = var.aurora_instance_class
  aurora_number_of_instances   = var.aurora_number_of_instances
  preferred_maintenance_window = var.aurora_preferred_maintenance_window
  monitoring_interval          = var.aurora_monitoring_interval
  enable_rds_proxy             = false
  db_credentials_secrets       = var.db_credentials_secrets
  lambdas_subnet_ids           = var.private_subnet_ids

  msk_cmk_arn            = module.tm_kms_infra.kms_msk_arn
  aurora_cmk_arn         = module.tm_kms_infra.kms_aurora_arn
  ssm_cmk_arn            = module.tm_kms_infra.kms_ssm_arn
  secretsmanager_cmk_arn = module.tm_kms_infra.kms_secrets_manager_arn
  sns_cmk_arn            = module.tm_kms_infra.kms_sns_arn
  cloudwatch_cmk_arn     = module.tm_kms_infra.kms_cloudwatch_arn
  kms_lambda_arn         = module.tm_kms_infra.kms_lambda_arn

  aurora_working_hours_start_cron      = var.aurora_working_hours_start_cron
  aurora_working_hours_end_cron        = var.aurora_working_hours_end_cron
  iam_openid_connect_provider_url      = module.tm_kubernetes_infra.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn      = module.tm_kubernetes_infra.iam_openid_connect_provider_arn
  apps_control_plane_security_group_id = module.tm_kubernetes_infra.eks_control_plane_security_group_id
  apps_cluster_worker_node_role_name   = module.tm_kubernetes_base_deployments.eks_node_group_iam_role_name
  apps_jumphost_role_name              = module.tm_kubernetes_infra.admin_jumphost_iam_role_name
  sns_metric_alert_topic_arn           = module.tm_kubernetes_infra.sns_metric_alert_topic_arn
}

module "tm_applications" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source  = "spacelift.io/gft-blx/skeleton-tm-applications/aws"
  version = "1.0.4"

  environment = var.environment
  region      = var.region
  component   = var.component

  vpc_id            = var.vpc_id
  public_subnet_ids = var.public_subnet_ids

  enable_ui                               = var.tm_monitoring_enable_ui
  enable_vautl_ui                         = var.tm_monitoring_enable_ui
  public_domain_name                      = var.public_domain_name
  eks_workers_subnet_cidrs                = var.eks_workers_subnet_cidrs
  secretsmanager_cmk_arn                  = module.tm_kms_infra.kms_secrets_manager_arn
  waf_s3_logs_cmk_arn                     = module.tm_kms_infra.kms_s3_eks
  tm_monitoring_ingress_allowed_ip_ranges = var.tm_monitoring_ingress_allowed_ip_ranges
  tm_vault_core_ingress_allowed_ip_ranges = var.tm_vault_core_ingress_allowed_ip_ranges

  iam_openid_connect_provider_url = module.tm_kubernetes_infra.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = module.tm_kubernetes_infra.iam_openid_connect_provider_arn
  tm_namespace                    = "tm-system"
  application_name                = "vault-installer"
  policy_arns                     = aws_iam_policy.vault_installer.arn
  permissions_boundary            = aws_iam_policy.vault_installer.arn
}
