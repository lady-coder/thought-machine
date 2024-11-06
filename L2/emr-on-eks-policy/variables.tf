variable "bucket_arns" {
  description = "List of bucket arn"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "Region"
  type        = string
}

variable "account_id" {
  description = "Current AWS Account ID"
  type        = string
}

variable "mwaa_name" {
  description = "(Optional) The name of the Apache Airflow MWAA Environment"
  type        = string
  default     = null
}
