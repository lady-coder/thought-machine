variable "secret_names" {
  type        = set(string)
  description = "List of secrets to be created in Secret Manager"
  default     = []
}

variable "secretsmanager_cmk_arn" {
  type        = string
  description = "The ARN for the Secrets Manager CMK's encryption key"
}

variable "secrets" {
  type        = map(string)
  description = "List of secrets contain secret_names and secret_strings"
  default     = {}
  #  example
  #  secrets = {
  #    secret_name = secret_strings,
  #    ...
  #  }
}
