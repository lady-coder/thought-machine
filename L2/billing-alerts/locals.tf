data "aws_caller_identity" "current" {
  provider = aws.billing
}

locals {
  current_account_id = data.aws_caller_identity.current.account_id
  root_arn           = "arn:aws:iam::${local.current_account_id}:root"
}
