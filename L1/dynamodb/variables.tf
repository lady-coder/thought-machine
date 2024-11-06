variable "env" {
  description = "Environment"
  type        = string
}

variable "component" {
  description = "Component name"
  type        = string
}

variable "prefix" {
  description = "Prefix name"
  type        = string
}

variable "kms_key_arn" {
  type        = string
  description = "kms_key_arn"
}

variable "billing_mode" {
  type        = string
  description = "Controls how you are charged for read and write throughput and how you manage capacity"
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
    error_message = "Allowed values for billing_mode are: PAY_PER_REQUEST | PROVISIONED."
  }
}

variable "read_capacity" {
  type        = number
  description = "Number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
  default     = null
}

variable "write_capacity" {
  type        = number
  description = "Number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
  default     = null
}

variable "hash_key" {
  type        = string
  description = "Name of the hash key in the index"
}

variable "attributes" {
  type = list(object({
    name = string
    type = string
  }))
  description = "Basic units of information, like key-value pairs. An attribute is comparable to a column in a relational database"
}

