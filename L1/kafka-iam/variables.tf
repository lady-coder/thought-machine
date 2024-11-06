variable "region" {
  type        = string
  description = "Region"
}

variable "glue_registry" {
  description = "Glue Schema Registry name"
  type        = string
}

variable "msk_cluster_name" {
  description = "MSK cluster name"
  type        = string
}

variable "role" {
  description = "Name of a role where policies will be attached to"
  type        = string
}

variable "policy_prefix" {
  description = "Prefix of policies names"
  type        = string
}

variable "readonly_topics" {
  description = "Kafka topics with readonly permissions"
  type        = list(string)
  default     = []
}

variable "readwrite_topics" {
  description = "Kafka topics with read and write permissions"
  type        = list(string)
  default     = []
}

variable "allow_role_self_assume" {
  description = "Add sts:AssumeRole to the role"
  type        = bool
  default     = true
}
