data "aws_caller_identity" "current" {}

locals {
  eks_cluster_name = lower(join("-", compact([var.prefix, var.environment, var.component])))
}
