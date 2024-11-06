data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  azs        = data.aws_availability_zones.available.names
  min_subnet_length = min(
    length(var.private_subnets),
    length(var.public_subnets),
  )

  nat_gateway_count = min(var.number_of_nats, local.min_subnet_length)

  prefix      = [var.environment, var.component, var.context]
  name_prefix = join("-", compact(local.prefix))
}
