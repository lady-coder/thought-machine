variable "environment" {
  type        = string
  description = "Environment"
}

variable "subscriber_emails" {
  description = "The email addresses of subscribers."
  type        = set(string)
}
