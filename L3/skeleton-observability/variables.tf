variable "prefix" {
  description = "prefix"
  type        = string
  default     = "nbo"
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "kms_cmk_sns" {
  description = "The ARN for the SNS CMK's encryption key"
  type        = string
}

variable "k8s_pod_alerts" {
  type        = map(any)
  description = "Map of pod alert"
}

variable "component" {
  type        = string
  description = "component"
}

variable "slack_workspace_id" {
  type        = string
  description = "Our slack workspace id"
}
