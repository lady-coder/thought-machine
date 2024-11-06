locals {
  name = join("-", compact([var.prefix, var.environment, var.component, var.context]))
}
