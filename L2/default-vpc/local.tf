data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  azs        = data.aws_availability_zones.available.names
  max_subnet_length = max(
    length(var.private_subnets),
    length(var.public_subnets),
  )
  nat_gateway_count = var.single_nat_gateway ? 1 : (var.one_nat_gateway_per_az ? length(local.azs) : local.max_subnet_length)
  prefix            = [var.environment, var.component, var.context]
  name_prefix       = join("-", compact(local.prefix))
}
