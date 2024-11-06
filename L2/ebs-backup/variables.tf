variable "environment" {
  type        = string
  default     = ""
  description = "Environment"
}


variable "component" {
  type        = string
  default     = ""
  description = "Component"
}

variable "prefix" {
  type        = string
  description = "prefix"
}

variable "tags" {
  description = "(optional)"
  type        = map(string)
  default     = null
}

variable "ebs_tags_name" {
  description = "EBS tag name"
  type        = string
  default     = null
}

variable "ebs_tags_value" {
  description = "EBS tag values"
  type        = list(string)
  default     = null
}

variable "kms_key_arn" {
  type        = string
  description = "kms_key_arn"
}
