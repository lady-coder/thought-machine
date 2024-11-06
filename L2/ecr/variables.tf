variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "Region in which the resources will be deployed"
}

variable "ecr_iam_principal" {
  type        = set(string)
  default     = []
  description = "List of internal IAM principals which will be allowed by default to pull and push from all of the repositories"
}

variable "readonly_external_aws_iam_principals" {
  type        = set(string)
  default     = []
  description = "List of external IAM principals for which the custom access policies will be configured"
}

variable "ecr_repositories" {
  type        = set(string)
  description = "List of ECR repositories to be created"
}

variable "pullthroughcache_repositories" {
  type        = set(string)
  description = "List of ECR pull through cache allowed repositories to be created"
  default     = []
}

variable "kms_cmk_ecr" {
  type        = string
  description = "The ARN for the ECR CMK's encryption key"
}
