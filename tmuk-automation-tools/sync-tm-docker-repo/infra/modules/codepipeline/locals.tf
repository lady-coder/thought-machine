data "aws_caller_identity" "current" {}

locals {
  name       = join("-", compact([var.environment, var.component, var.context]))
  account_id = data.aws_caller_identity.current.account_id
}
