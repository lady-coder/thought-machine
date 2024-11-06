variable "environment" {
  type        = string
  description = "Environment"
}

variable "component" {
  type        = string
  description = "component"
}

variable "region" {
  type        = string
  description = "region"
}

variable "prefix" {
  type        = string
  description = "prefix"
}

variable "context" {
  type        = string
  description = "context, optional parameter added at the end of the web ACL prefix, containing for example name of the application"
}

variable "require_api_key" {
  type        = bool
  description = "Enable/Disable block_x_api_key rule"
}

#tfsec:ignore:general-secrets-sensitive-in-variable
variable "api_key" {
  type        = string
  sensitive   = true
  description = "api_key to access graphql"
  default     = ""
}

variable "allowed_paths" {
  type        = list(string)
  description = "list of allowed paths"
  default     = []
}

variable "ip_rate_based_limit_per_5min" {
  type        = number
  description = "Number of limit to IP in span 5 minutes"
}

variable "max_payload_size_in_bytes" {
  type        = number
  description = "A size_constraint rule tracks the size of requests for each originating IP address, and triggers the rule action when the size exceeds"
}

variable "managed_rules_common_rules_excluded" {
  type        = list(string)
  description = "list of managed_rules_commonrule_excluded"
  default     = []
}

variable "managed_rules_linux_rules_excluded" {
  type        = list(string)
  description = "list of managed_rules_linux_rule_excluded"
  default     = []
}

variable "enable_logging" {
  type        = bool
  description = "Enable/Disable log storage for WAF"
  default     = true
}

variable "blocked_countries" {
  type        = list(string)
  description = "All the request from these countries will be blocked by WAF"
  default     = []
}

variable "kms_s3_arn" {
  type        = string
  description = "CMK for S3"
}
