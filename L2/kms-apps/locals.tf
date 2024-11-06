locals {
  account_name = join("-", compact([var.prefix, var.environment, var.component]))
}
