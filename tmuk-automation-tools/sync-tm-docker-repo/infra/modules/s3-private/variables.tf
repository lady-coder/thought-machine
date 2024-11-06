variable "environment" {
  type        = string
  description = "Environment"
}

variable "component" {
  type        = string
  description = "Component"
}

variable "context" {
  type        = string
  description = "Context"
  default     = ""
}

variable "prefix" {
  type        = string
  description = "Prefix that is always at the beginning of the bucket name"
  default     = ""
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key's ARN for encryption of the bucket"
}

variable "extended_policy_json" {
  type        = string
  description = "S3 bucket policy to be merged with the default one"
  default     = ""
}

variable "enable_versioning" {
  type        = bool
  description = "Enabled/Disabled versioning"
  default     = true
}

variable "object_lock_enabled" {
  type        = bool
  description = "Enabled/Disabled object lock configuration"
  default     = true
}
