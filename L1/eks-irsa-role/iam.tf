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

data "aws_iam_policy_document" "assume_itself" {
  count = var.allow_role_self_assume ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${join("-", compact([var.scope, var.application_name, var.role_context, "eks-irsa-role"]))}"]
    }
  }
}

data "aws_iam_policy_document" "assume_third_party" {
  count = var.allow_third_party_assume_role ? 1 : 0
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      identifiers = [var.custom_iam_openid_connect_provider_arn]
      type        = "Federated"
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.custom_iam_openid_connect_provider_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "${replace(var.custom_iam_openid_connect_provider_url, "https://", "")}:sub"
      values   = [var.assume_third_party_condition_values]
    }
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = compact([
    data.aws_iam_policy_document.assume_role.json,
    var.allow_role_self_assume ? data.aws_iam_policy_document.assume_itself[0].json : "",
    var.allow_third_party_assume_role ? data.aws_iam_policy_document.assume_third_party[0].json : "",
  ])
}

resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.combined.json
  name               = join("-", compact([var.scope, var.application_name, var.role_context, "eks-irsa-role"]))
}

resource "aws_iam_role_policy" "inline" {
  count = var.inline_policy != "" ? 1 : 0

  name   = join("-", compact([var.scope, var.application_name, "inline-policy"]))
  role   = aws_iam_role.this.name
  policy = var.inline_policy
}

resource "aws_iam_role_policy_attachment" "policy_assignment" {
  for_each = toset(var.policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
