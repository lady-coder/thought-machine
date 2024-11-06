data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.iam_openid_connect_provider_url, "https://", "")}:sub"
      values   = [local.service_account_name]
    }

    principals {
      identifiers = [var.iam_openid_connect_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "this" {
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  name                 = join("-", compact([local.scope, var.application_name, var.role_context, "eks-irsa-role"]))
  permissions_boundary = var.permissions_boundary
}

resource "aws_iam_role_policy_attachment" "policy_assignment" {
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arns
}
