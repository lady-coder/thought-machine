variable "region" {
  description = "Region"
  type        = string
}

variable "region_ecr" {
  description = "Region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "component" {
  type        = string
  description = "Component"
}

variable "prefix" {
  type        = string
  description = "Prefix"
}

variable "github_org_url" {
  description = "Github organization URL"
  type        = string
}

variable "platform_git_ops_repo_name" {
  description = "Name of GitOps repository containing configurations of all platform applications"
  type        = string
}

variable "applications_git_ops_repo_name" {
  description = "Name of GitOps repository containing configurations of all microservices and automation applications"
  type        = string
  default     = ""
}

variable "argocd_github_oauth_app_client_id" {
  description = "Client ID of a ArgoCD GitHub OAuth App"
  type        = string
  default     = ""
}

variable "argocd_github_app_id" {
  description = "ID of a ArgoCD GitHub App"
  type        = string
  default     = ""
}

variable "argocd_github_app_installation_id" {
  description = "Installation ID of a ArgoCD GitHub App"
  type        = string
  default     = ""
}

variable "enable_ui" {
  type        = bool
  description = "Enable ArgoCD UI and GitHub authentication"
}

variable "aws_admin_role_name" {
  type        = string
  description = "IAM Role used by AWS SSO admin users"
}

variable "kubernetes_version" {
  type    = string
  default = "1.23"
}

variable "node_groups" {
  type = map(object({
    disk_size                     = number
    instance_types                = list(string)
    capacity_type                 = string
    subnet_ids                    = list(string)
    desired_capacity              = number
    max_size                      = number
    min_size                      = number
    downscale_after_working_hours = bool
    downscale_schedule_cron       = string
    upscale_schedule_cron         = string
    kubernetes_taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = {
    on_demand = {
      disk_size                     = 50
      instance_types                = ["t3.micro"]
      capacity_type                 = "ON_DEMAND"
      subnet_ids                    = []
      desired_capacity              = 1
      max_size                      = 10
      min_size                      = 1
      downscale_after_working_hours = false
      downscale_schedule_cron       = ""
      upscale_schedule_cron         = ""
      kubernetes_taints             = []
    }
  }
}

variable "env_dedicated_irsa_roles" {
  type = map(object({
    namespace                              = string
    application_name                       = string
    inline_policy                          = string
    policy_arns                            = optional(list(string), [])
    allow_role_self_assume                 = optional(bool, false)
    allow_third_party_assume_role          = optional(bool, false)
    assume_third_party_condition_values    = optional(string, null)
    custom_iam_openid_connect_provider_url = optional(string, null)
    custom_iam_openid_connect_provider_arn = optional(string, null)
  }))
}

variable "ami_type" {
  default = "AL2_x86_64"
  type    = string
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}

variable "admin_jumphost_iam_role_name" {
  type        = string
  description = "Name of admin jumphost role"
}

variable "iam_openid_connect_provider_url" {
  type        = string
  description = "EKS OIDC url"
}

variable "iam_openid_connect_provider_arn" {
  type        = string
  description = "EKS OIDC ARN"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "eks_cluster_id" {
  type        = string
  description = "EKS cluster ID"
}

variable "eks_control_plane_security_group_id" {
  type        = string
  description = "EKS control plane security group"
}

variable "eks_cluster_certificate_authority" {
  type        = string
  description = "EKS cluster CA"
}

variable "eks_cluster_endpoint" {
  type        = string
  description = "EKS cluster endpoint"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the skeleton will be deployed"
  default     = ""
}

variable "public_domain_name" {
  type        = string
  description = "Public domain name for which the ACM certificates will be generated"
  default     = ""
}

variable "argocd_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access ArgoCD UI"
  default     = []
}

variable "eks_workers_subnet_cidrs" {
  type        = list(string)
  description = "List of cluster private subnets CIDRs which will be added to the ALB security groups egress rules"
  default     = []
}

variable "waf_s3_logs_cmk_arn" {
  type        = string
  description = "CMK for S3"
  default     = ""
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnets IDs"
  default     = []
}

variable "approvers_repository_access" {
  type        = map(list(string))
  description = "Teams and their repositories they can sync"
}

variable "eks_additional_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "Additional IAM roles to add to the aws-auth ConfigMap"
}

variable "custome_iam_openid_connect_provider_url" {
  type        = string
  description = "Third-party OIDC Provider URL"
  default     = null
}

variable "custome_iam_openid_connect_provider_arn" {
  type        = string
  description = "Third-party OIDC Provider ARN"
  default     = null
}

variable "external_secrets_version" {
  type        = string
  description = "external_secrets_version"
  default     = ""
}

variable "shared_services_account_id" {
  type        = string
  description = "AWS Account ID of shared-services"
  default     = ""
}

variable "argocd_version" {
  type        = string
  description = "argocd_version"
  default     = ""
}

variable "redis_version" {
  type        = string
  description = "redis_version"
  default     = ""
}

variable "infrastructure_path" {
  description = "Path of the infrastructure resources"
  type        = string
  default     = "infrastructure"
}

variable "additional_secrets_range_arn" {
  description = "Additional ranges of secret arns in Secret Manager"
  type        = list(string)
  default     = []
}
