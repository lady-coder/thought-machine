data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  azs         = data.aws_availability_zones.available.names
  prefix      = [var.environment, var.component, var.context]
  name_prefix = join("-", compact(local.prefix))
}
