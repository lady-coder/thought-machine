resource "aws_iam_role" "emr_on_eks_execution" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  name                  = local.emr_on_eks_job_execution_role
  assume_role_policy    = data.aws_iam_policy_document.emr_assume_role.json
  force_detach_policies = true
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = (var.create_emrcontainers_virtual_cluster && length(var.emr_on_eks_additional_iam_policies) > 0) ? 1 : 0

  role       = aws_iam_role.emr_on_eks_execution[count.index].name
  policy_arn = var.emr_on_eks_additional_iam_policies[count.index]
}
