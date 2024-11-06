variable "region" {
  type        = string
  description = "Region in which the resources will be deployed"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "spacelift_repositories" {
  type        = set(string)
  description = "List of spacelift dedicated ECR repositories"
}

variable "platform_repositories" {
  type        = set(string)
  description = "List of ArgoCD dedicated ECR repositories"
}

variable "ecr_iam_principal" {
  type        = set(string)
  description = "List of internal IAM principals which will be allowed by default to pull and push from all of the repositories"
}
