data "aws_caller_identity" "current" {}

data "aws_partition" "this" {}

data "aws_iam_policy_document" "pullpush_policy" {
  dynamic "statement" {
    for_each = var.ecr_iam_principal != [] ? [1] : []

    content {
      sid    = "AllowPullPush"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.ecr_iam_principal
      }
      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ]
    }
  }

  dynamic "statement" {
    for_each = var.readonly_external_aws_iam_principals != [] ? [1] : []

    content {
      sid    = "EcrReadOnlyDevAccess"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.readonly_external_aws_iam_principals
      }
      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
        "ecr:GetLifecyclePolicy",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:ListTagsForResource",
        "ecr:DescribeImageScanFindings"
      ]
    }
  }
}

data "aws_iam_policy_document" "pullthroughcache_policy" {
  dynamic "statement" {
    for_each = var.readonly_external_aws_iam_principals != [] ? [1] : []

    content {
      sid    = "AllowPullThroughCache"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.readonly_external_aws_iam_principals
      }
      actions = [
        "ecr:CreateRepository",
        "ecr:BatchImportUpstreamImage"
      ]
      resources = [
        for remote_ecr_repository in var.pullthroughcache_repositories :
        "arn:${data.aws_partition.this.partition}:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/ecr-public/${remote_ecr_repository}"
      ]
    }
  }
}

data "aws_iam_policy_document" "pullthroughcache_ecr_sharing" {
  dynamic "statement" {
    for_each = var.readonly_external_aws_iam_principals != [] ? [1] : []

    content {
      sid    = "AllowPullThroughCacheCrossAccount"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.readonly_external_aws_iam_principals
      }
      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:GetAuthorizationToken"
      ]
    }
  }
}
