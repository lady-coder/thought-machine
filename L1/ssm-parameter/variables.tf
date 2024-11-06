variable "environment" {
  type        = string
  description = "Environment, for example sandbox or dev"
}

variable "component" {
  type        = string
  description = "Component, for example platform"
}

variable "resource" {
  type        = string
  description = "Type of AWS resource"
}

variable "parameter_name" {
  type        = string
  description = "Name of the parameter"
}

variable "description" {
  type        = string
  description = "Description of the parameter"
}

variable "value" {
  type        = string
  description = "Value to be stored in the parameter"
}

variable "cmk_key_id" {
  type        = string
  description = "ID of SSM dedicated CMK key"
}
