locals {
  scope                = "${var.environment}-${var.component}"
  application_name     = var.application_name
  service_account_name = "system:serviceaccount:${var.tm_namespace}:${var.application_name}"
}
