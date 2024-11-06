variable "workgroup_id" {
  type        = string
  description = "Athena workgroup id."
  default     = "primary"
}

variable "s3_bucket_id" {
  description = "Use an existing S3 bucket for Athena query results if `create_s3_bucket` is `false`."
  type        = string
  default     = null
}

variable "s3_output_path" {
  description = "The S3 bucket path used to store query results."
  type        = string
  default     = ""
}

variable "workgroup_description" {
  description = "A description the of Athena workgroup."
  type        = string
  default     = ""
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760."
  type        = number
  default     = null
}

variable "enforce_workgroup_configuration" {
  description = "Boolean whether the settings for the workgroup override client-side settings."
  type        = bool
  default     = true
}

variable "publish_cloudwatch_metrics_enabled" {
  description = "Boolean whether Amazon CloudWatch metrics are enabled for the workgroup."
  type        = bool
  default     = false
}

variable "workgroup_encryption_option" {
  description = "Encryption key block AWS Athena uses to decrypt the data in S3."
  type        = string
  default     = "SSE_KMS"
}

variable "athena_engine_version" {
  description = "The Athena engine version for running queries"
  type        = string
  default     = "Athena engine version 3"
}

variable "workgroup_state" {
  description = "State of the workgroup. Valid values are `DISABLED` or `ENABLED`."
  type        = string
  default     = "ENABLED"
}

variable "workgroup_force_destroy" {
  description = "The option to delete the workgroup and its contents even if the workgroup contains any named queries."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key ARN."
  default     = ""
}