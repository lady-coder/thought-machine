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

variable "phase" {
  type        = string
  description = "Phase of the build project"
  default     = "build"

}

variable "environment_image" {
  type        = string
  description = "Docker image to use for the build environment"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "vpc_subnets" {
  type        = list(string)
  description = "List of VPC subnets to use"
}

variable "compute_type" {
  type        = string
  description = "Type of compute resources to use for the build"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "codecommit_repository_name" {
  type        = string
  description = "Name of the CodeCommit repository containing the source code"
  default     = ""
}

variable "codecommit_branch" {
  type        = string
  description = "Name of the branch in the CodeCommit repository containing the source code"
  default     = "refs/heads/main"
}

variable "logs_status" {
  type        = string
  description = "Current status of logs in Cloudwatch Logs"
  default     = "ENABLED"
}

variable "s3_artifacts" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "cloudwatch_kms_arn" {
  description = "KMS arn for encrypt or decryp CloudWatch Logs"
  type        = string
}

variable "artifact_log_file" {
  type        = string
  description = "Output file generated after CodeBuild run completes"
  default     = "sync-error.log"
}

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "codebuild_access_secret_arn" {
  type        = string
  description = "AWS Secret Manager ARN that codebuild will access to retrieve credentials"
}

variable "logs_retention_days" {
  description = "Number of days to retain logs for CodePipeline in CloudWatch Logs."
  type        = number
  default     = 7
}
