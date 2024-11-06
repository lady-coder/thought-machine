
variable "region" {
  type        = string
  description = "Region in which the resources will be deployed"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "prefix" {
  type        = string
  description = "Project prefix"
  default     = ""
}

variable "L4_tags" {
  type        = map(string)
  description = "Map of predefined L4 tags"
}

variable "shared_service_admin_role" {
  type        = string
  description = "Admin role of shared service account on the desired account region"
}

variable "shared_service_github_role" {
  type        = string
  description = "CI/CD Role that Github Actions utilise that to have access to ECR repositories."
}

variable "platform_helm_chart_ecr_prefix" {
  type        = string
  description = "Prefix for the platform dedicated helm chart ECRs"
  default     = "platform/helm"
}

variable "platform_image_ecr_prefix" {
  type        = string
  description = "Prefix for the platform dedicated helm chart ECRs"
  default     = "platform/images"
}
