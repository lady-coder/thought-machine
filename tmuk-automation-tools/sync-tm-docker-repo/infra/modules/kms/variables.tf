variable "account_name" {
  description = "Account name used in alias"
}

variable "service_name" {
  description = "Service that uses this key, eg.: s3, rds"
  type        = string
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  default     = true
}

variable "admin_arns" {
  description = "List of IAM role ARNs to be assigned with key admin"
  default     = []
}

variable "decrypt_arns" {
  description = "List of IAM role ARNs to be assigned with decryption right only"
  default     = []
}

variable "services_principal" {
  type        = set(string)
  description = "List of AWS Service principal that are allowed to use the KMS key"
  default     = []
}

variable "service_principals_with_general_conditions" {
  description = "Accept a set of services together with each having a set of conditions to evaluate"
  default     = []
  type = set(object({
    svc_identifiers = set(string)
    condition = set(object({
      test     = string
      variable = string
      values   = set(string)
    }))
  }))
}

variable "cross_account_principals" {
  description = "List ARN of the role/user/root-account-ID of any external environment to be allowlisted to use this KMS"
  type        = set(string)
  default     = []
}

variable "enable_cloudwatch_alarm" {
  type    = bool
  default = false
}

variable "enable_waf" {
  description = "Allow AWS Web Application Firewall to produce encrypted logs into destination i.e. S3 bucket"
  type        = bool
  default     = false
}
