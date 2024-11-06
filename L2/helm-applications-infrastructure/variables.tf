
variable "environment" {
  description = "Environment"
  type        = string
}

variable "namespace" {
  description = "Name of a namespace where argocd will be deployed"
  type        = string
  default     = "argo-cd"
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
}

variable "argocd_namespace" {
  type        = string
  description = "Unused. Express dependency"
}

variable "infrastructure_path" {
  description = "Path of the infrastructure resources"
  type        = string
  default     = "infrastructure"
}
