locals {
  eks_cluster_name = join("-", compact([var.prefix, var.environment, var.component]))
}
