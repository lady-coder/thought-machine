data "aws_caller_identity" "current" {}

locals {
  eks_iam_node_group_role_name    = "${var.environment}-${var.component}-eks-common-worker-role"
  platform_secrets_range_arn      = "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:/${var.environment}/${var.component}/platform/*"
  microservices_secrets_range_arn = "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:/${var.environment}/${var.component}/digibank/*"
}
