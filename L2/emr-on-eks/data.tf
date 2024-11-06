data "aws_iam_policy_document" "emr_assume_role" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["elasticmapreduce.amazonaws.com"]
      type        = "Service"
    }
  }

  dynamic "statement" {
    for_each = (var.eks_oidc_provider_url != null && var.emr_on_eks_namespace != null && var.emr_service_name != null) ? [1] : [0]

    content {
      effect = "Allow"
      principals {
        identifiers = [local.eks_oidc_provider_arn]
        type        = "Federated"
      }
      actions = [
        "sts:AssumeRoleWithWebIdentity"
      ]
      condition {
        test     = "StringEquals"
        variable = "${local.eks_oidc_issuer_url}:sub"

        values = [
          "system:serviceaccount:${var.emr_on_eks_namespace}:${var.emr_service_name}"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.eks_oidc_issuer_url}:aud"

        values = [
          "sts.amazonaws.com"
        ]
      }
    }
  }
}

data "external" "b36" {
  program = ["python", "${path.module}/tools/b36.py"]

  query = {
    value = local.emr_on_eks_job_execution_role
  }
}
