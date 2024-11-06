data "aws_iam_policy_document" "mwaa_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["airflow.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["airflow-env.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
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
        test     = "StringLike"
        variable = "${local.eks_oidc_issuer_url}:sub"

        values = [
          "system:serviceaccount:${var.emr_on_eks_namespace}:emr-containers-sa-*-*-${var.account_id}-*"
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

#tfsec:ignore:AWS099
data "aws_iam_policy_document" "mwaa" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  statement {
    effect = "Allow"
    actions = [
      "airflow:PublishMetrics",
      "airflow:CreateWebLoginToken"
    ]
    resources = [
      "arn:aws:airflow:${var.region}:${var.account_id}:environment/${var.mwaa_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:List",
      "s3:Describe*"
    ]
    resources = var.datalake_bucket_arns
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      var.source_bucket_arn,
      "${var.source_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogRecord",
      "logs:GetLogGroupFields",
      "logs:GetQueryResults"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:airflow-${var.mwaa_name}-*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "cloudwatch:PutMetricData",
      "s3:GetAccountPublicAccessBlock",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    resources = [
      "arn:aws:sqs:${var.region}:*:airflow-celery-*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt"
    ]
    resources = [
      "arn:aws:kms:${var.region}:${var.account_id}:key/*",
    ]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"

      values = [
        "sqs.${var.region}.amazonaws.com",
        "s3.${var.region}.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"

      values = [
        "arn:aws:logs:${var.region}:${var.account_id}:*"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "batch:*",
    ]
    resources = [
      "arn:aws:batch:*:${var.account_id}:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:*"
    ]
    resources = [
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = ["arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/lambda/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/lambda/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["cs3:GetObject"]
    resources = ["arn:aws:s3:::prod-region-starport-layer-bucket/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = ["arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values = [
        "events.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy"
    ]
    resources = ["arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "emr-containers:*",
    ]
    resources = [
      "arn:aws:emr-containers:${var.region}:${var.account_id}:/*"
    ]
  }
}
