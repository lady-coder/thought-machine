variable "secret_names" {
  type        = set(string)
  description = "List of secrets to be created in Secret Manager"
}

variable "secretsmanager_cmk_arn" {
  type        = string
  description = "The ARN for the Secrets Manager CMK's encryption key"
}
