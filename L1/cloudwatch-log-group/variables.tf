variable "log_group_name" {
  type        = string
  description = "Name of the log group"
}

variable "cloudwatch_kms_key_arn" {
  type        = string
  description = "ARN of cloudwatch dedicated CMK"
}

variable "retention_in_days" {
  type        = number
  description = "Log group retention in days. Possible values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (never expire)"
}
