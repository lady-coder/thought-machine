variable "region" {
  type        = string
  description = "Region"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "component" {
  type        = string
  description = "Component"
}

variable "prefix" {
  description = "Project prefix"
  type        = string
  default     = ""
}
