variable "region" {
  description = "Region"
  type        = string
}

variable "prefix" {
  description = "prefix"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "component" {
  type        = string
  description = "component"
}

variable "kms_secrets_manager_arn" {
  description = "ARN of Secret manager KMS key"
  type        = string
}
