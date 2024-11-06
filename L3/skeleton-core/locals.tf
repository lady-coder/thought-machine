data "aws_caller_identity" "current" {}

locals {
  msk_cluster_name    = "${var.component}-kafka"
  aurora_cluster_name = "${var.component}-aurora-cluster-db"
}
