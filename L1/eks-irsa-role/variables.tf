variable "scope" {
  type        = string
  description = "Choose between 'platform' or 'services'"
}

variable "application_name" {
  type        = string
  description = "Name of the role"
}

variable "role_context" {
  type        = string
  description = "additional context added to the name of the role"
  default     = ""
}

variable "iam_openid_connect_provider_url" {
  type        = string
  description = "URL of OIDC provider for target cluster"
}

variable "iam_openid_connect_provider_arn" {
  type        = string
  description = "ARN of OIDC provider for target cluster"
}

variable "inline_policy" {
  type        = string
  description = "JSON encoded policy object to be injected to the role as an inline policy"
  default     = ""
}

variable "namespace" {
  type        = string
  description = "Namespace in which the serviceaccount is placed"
}

variable "policy_arns" {
  type        = list(string)
  description = "List of policy arns to be attached to the role"
  default     = []
}

variable "allow_role_self_assume" {
  description = "Add sts:AssumeRole to the role"
  type        = bool
  default     = false
}

variable "allow_third_party_assume_role" {
  description = "Allow third party assume the role"
  type        = bool
  default     = false
}

variable "assume_third_party_condition_values" {
  type        = string
  description = "Condition value of 3rd-party OIDC provider's condition value for target object"
  default     = null
}

variable "custom_iam_openid_connect_provider_url" {
  type        = string
  description = "URL of 3rd-party OIDC provider for target object"
  default     = ""
}

variable "custom_iam_openid_connect_provider_arn" {
  type        = string
  description = "ARN of 3rd-party OIDC provider for target object"
  default     = null
}
