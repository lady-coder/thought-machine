
variable "environment" {
  description = "Environment"
  type        = string
}

variable "component" {
  type        = string
  description = "Component"
}

variable "irsa_role_arn" {
  type        = string
  description = "ARN of an IRSA role dedicated for external-secrets"
}

variable "node_group_role_arn" {
  type        = string
  description = "Unused. Express dependency"
}

variable "shared_services_account_id" {
  type        = string
  description = "Shared-services AWS Account ID"
}

variable "external_secrets_version" {
  type        = string
  description = "external_secrets_version"
}

variable "region_ecr" {
  description = "Region"
  type        = string
}
