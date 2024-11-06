variable "environment" {
  type        = string
  description = "Environment"
}

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "Region in which the resources will be deployed"
}

variable "component" {
  type        = string
  description = "component"
}

variable "context" {
  type        = string
  default     = ""
  description = "context"
}

variable "source_repo_name" {
  description = "Source repo name of the CodeCommit repository"
  type        = string
}

variable "source_repo_branch" {
  description = "Default branch in the Source repo for which CodePipeline needs to be configured"
  type        = string
}

variable "s3_artifacts" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "stages" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = list(map(any))
}

