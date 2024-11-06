
data "aws_iam_policy_document" "general_policy" {
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

  statement {
    sid    = "Allow access for Key Administrators"
    effect = "Allow"

    principals {
      identifiers = local.admin_arns
      type        = "AWS"
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Allow use of the key for decryption only"
    effect = "Allow"

    principals {
      identifiers = local.decrypt_user_arns
      type        = "AWS"
    }

    actions = ["kms:Decrypt"]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "combined_with_viaservice_condition" {
  source_policy_documents = [data.aws_iam_policy_document.general_policy.json]

  dynamic "statement" {
    for_each = var.services_principal

    content {
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
        values   = [statement.value]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [local.current_account_id]
      }

      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.enable_cloudwatch_alarm ? [1] : []
    content {
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

  dynamic "statement" {
    for_each = length(var.cross_account_principals) > 0 ? [1] : []

    content {
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
        identifiers = var.cross_account_principals
        type        = "AWS"
      }

      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.enable_waf ? [1] : []

    content {
      sid = "Allow Network Firewall to use the key"

      actions = [
        "kms:GenerateDataKey*"
      ]

      effect = "Allow"

      principals {
        identifiers = ["delivery.logs.amazonaws.com"]
        type        = "Service"
      }

      resources = ["*"]
    }
  }
}

data "aws_iam_policy_document" "combined_with_serviceprincipals_and_conditions" {
  source_policy_documents = [data.aws_iam_policy_document.general_policy.json]

  dynamic "statement" {
    for_each = var.service_principals_with_general_conditions

    content {
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
        type        = "Service"
        identifiers = statement.key.svc_identifiers
      }

      resources = ["*"]

      dynamic "condition" {
        for_each = statement.key.condition
        content {
          test     = condition.key.test
          variable = condition.key.variable
          values   = condition.key.values
        }
      }
    }
  }
}