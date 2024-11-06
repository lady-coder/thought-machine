variable "environment" {
  type        = string
  description = "Environment"
}

variable "component" {
  type        = string
  description = "component"
  default     = "datatech"
}

variable "region" {
  description = "Region"
  type        = string
}

variable "enable_versioning" {
  type        = bool
  description = "Enabled/Disabled versioning"
  default     = false
}

variable "kms_s3_arn" {
  type        = string
  description = "CMK for S3"
}

variable "object_lock_enabled" {
  type        = bool
  description = "Enabled/Disabled object lock configuration"
  default     = false
}
