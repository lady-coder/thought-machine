variable "region" {
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

variable "namespace" {
  description = "Name of a namespace where argocd will be deployed"
  type        = string
  default     = "tm-monitoring"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where ALB's security group will be created"
}

variable "public_domain_name" {
  type        = string
  description = "Public domain name for which the ACM certificates will be generated"
}

variable "tm_monitoring_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access TM monitoring UI"
}

variable "tm_vault_core_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access TM monitoring UI"
}

variable "waf_s3_logs_cmk_arn" {
  type        = string
  description = "CMK for S3"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnets IDs"
}

variable "enable_ui" {
  type        = bool
  description = "Enable ArgoCD UI and TM components (core and monitoring)"
}

variable "enable_vautl_ui" {
  type        = bool
  description = "Enable TM Vaul Core UI"
}

variable "eks_workers_subnet_cidrs" {
  type        = list(string)
  description = "List of cluster private subnets CIDRs which will be added to the ALB security groups egress rules"
}

variable "iam_openid_connect_provider_url" {
  type        = string
  description = "URL of OIDC provider for target cluster"
}

variable "iam_openid_connect_provider_arn" {
  type        = string
  description = "ARN of OIDC provider for target cluster"
}

variable "application_name" {
  type        = string
  description = "Name of the role"
}

variable "policy_arns" {
  type        = string
  description = "One Arn to be attached to the role"
  default     = ""
}

variable "role_context" {
  type        = string
  description = "additional context added to the name of the role"
  default     = ""
}

variable "permissions_boundary" {
  type        = string
  description = "One permissions boundary policy arn to be attached to the role"
  default     = ""
}

variable "tm_namespace" {
  description = "Name of a namespace where argocd will be deployed"
  type        = string
  default     = "tm-system"
}

variable "secret_prefix" {
  description = "Prefix for secrets from a specific Vault instance"
  type        = string
  default     = "tm-vault"
}

variable "tm_iam_prefix" {
  description = "Prefix paths for roles, policies and secrets"
  type        = string
  default     = "tm-prefix/sandbox-tm"
}

variable "secretsmanager_cmk_arn" {
  type        = string
  description = "CMK for Secrets Manager"
}

variable "prefix" {
  description = "Project prefix"
  type        = string
  default     = ""
}