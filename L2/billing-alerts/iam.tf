data "aws_iam_policy_document" "general_policy" {
  provider = aws.billing
  #checkov:skip=CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  statement {
    sid    = "Enable IAM Root User Permissions"
    effect = "Allow"

    principals {
      identifiers = [local.root_arn]
      type        = "AWS"
    }

    actions = ["kms:*"]

    resources = ["*"]
  }
}


data "aws_iam_policy_document" "combined_with_viaservice_condition" {
  provider = aws.billing
  #checkov:skip=CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  source_policy_documents = [data.aws_iam_policy_document.general_policy.json]

  statement {

    actions = [
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt"
    ]

    effect = "Allow"

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["sns.us-east-1.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [local.current_account_id]
    }

    resources = ["*"]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*"
    ]

    effect = "Allow"

    principals {
      identifiers = ["cloudwatch.amazonaws.com"]
      type        = "Service"
    }

    resources = ["*"]
  }

}
