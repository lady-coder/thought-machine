data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id

  bucket_context = join("-", compact([var.context, "operational"]))

  name = join("-", compact([var.prefix, var.environment, var.component, var.context]))
}
