variable "region" {
  description = "AWS Region"
  type        = string

  default = ""
}

variable "environment" {
  description = "Environment"
  type        = string

  default = ""
}

variable "component" {
  description = "Component Name"
  type        = string

  default = ""
}

variable "prefix" {
  type        = string
  description = "prefix"

  default = ""
}

variable "namespace" {
  description = "Name of a namespace where ArgoCD will be deployed"
  type        = string

  default = "argo-cd"
}

variable "github_org_url" {
  description = "Github Organization URL"
  type        = string

  default = ""
}

variable "github_oauth_app_client_id" {
  description = "Client ID of a ArgoCD GitHub OAuth App"
  type        = string

  default = ""
}

variable "github_app_id" {
  description = "ID of a ArgoCD GitHub App"
  type        = string

  default = ""
}

variable "github_app_installation_id" {
  description = "Installation ID of a ArgoCD GitHub App"
  type        = string

  default = ""
}

variable "vpc_id" {
  description = "ID of the VPC where ALB's security group will be created"
  type        = string

  default = ""
}

variable "public_domain_name" {
  description = "Public domain name for which the ACM certificates will be generated"
  type        = string

  default = ""
}

variable "argocd_ingress_allowed_ip_ranges" {
  description = "CIDRs allowed to access ArgoCD UI"
  type        = list(string)

  default = []
}

variable "eks_workers_subnet_cidrs" {
  description = "List of cluster private subnets CIDRs which will be added to the ALB security groups egress rules"
  type        = list(string)

  default = []
}

variable "waf_s3_logs_cmk_arn" {
  description = "CMK for S3"
  type        = string

  default = ""
}

variable "public_subnet_ids" {
  description = "List of public subnets IDs"
  type        = list(string)

  default = []
}

variable "enable_ui" {
  description = "Enable ArgoCD UI and GitHub authentication"
  type        = bool

  default = false
}

variable "approvers_repository_access" {
  description = "Teams and their repositories they can sync"
  type        = map(list(string))

  default = {}
}

variable "platform_base_role_arns_map" {
  description = "Mapping name of a base application IRSA role to its ARN"
  type = list(object({
    application_name = string
    role_arn         = string
  }))

  default = []
}

variable "platform_env_role_arns_map" {
  description = "Mapping name of a env dedicated application IRSA role to its ARN"
  type = list(object({
    application_name = string
    role_arn         = string
  }))

  default = []
}

variable "external_secrets_namespace" {
  description = "Unused. Express dependency"
  type        = string

  default = ""
}

variable "shared_services_account_id" {
  description = "Shared-services AWS Account ID"
  type        = string

  default = ""
}

variable "region_ecr" {
  description = "Region of the ECR private repositories"
  type        = string

  default = ""
}

variable "argocd_version" {
  description = "ArgoCD application version"
  type        = string

  default = ""
}

variable "redis_version" {
  description = "Redis application version"
  type        = string

  default = ""
}
