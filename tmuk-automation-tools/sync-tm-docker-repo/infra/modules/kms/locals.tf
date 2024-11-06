data "aws_caller_identity" "current" {}

locals {
  current_account_id = data.aws_caller_identity.current.account_id
  root_arn           = "arn:aws:iam::${local.current_account_id}:root"
  admin_arns         = concat(tolist([local.root_arn]), var.admin_arns)
  decrypt_user_arns  = concat(tolist([local.root_arn]), var.decrypt_arns)
}
