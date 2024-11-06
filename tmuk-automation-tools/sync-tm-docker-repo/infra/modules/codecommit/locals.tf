locals {
  name = join("-", compact([var.environment, var.component, var.context]))
}
