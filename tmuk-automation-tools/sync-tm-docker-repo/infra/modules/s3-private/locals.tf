data "aws_caller_identity" "current" {}
locals {
  account_id        = data.aws_caller_identity.current.account_id
  component_context = join("-", compact([var.component, var.context]))
  bucket_prefix     = join("-", compact([var.prefix, var.environment, local.account_id]))
}
