locals {
  service_account_name = "system:serviceaccount:${var.namespace}:${var.application_name}"
}
