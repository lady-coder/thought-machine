data "aws_iam_policy_document" "athena_outputs_bucket" {

  statement {
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [
      "${module.datatech_athenaoutputs_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:CalledVia"
      values   = ["athena.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "datalake_silver_customers_bucket" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }
    actions = [
      "s3:DeleteObject",
    ]
    resources = [
      "${module.datalake_silver_customers_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
    }
  }
}

data "aws_iam_policy_document" "datalake_gold_customers_bucket" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }
    actions = [
      "s3:DeleteObject",
    ]
    resources = [
      "${module.datalake_gold_customers_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
    }
  }
}

data "aws_iam_policy_document" "datalake_silver_deposits_bucket" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }
    actions = [
      "s3:DeleteObject",
    ]
    resources = [
      "${module.datalake_silver_deposits_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
    }
  }
}

data "aws_iam_policy_document" "datalake_gold_deposits_bucket" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }
    actions = [
      "s3:DeleteObject",
    ]
    resources = [
      "${module.datalake_gold_deposits_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
    }
  }
}

data "aws_iam_policy_document" "datalake_silver_accounts_bucket" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }
    actions = [
      "s3:DeleteObject",
    ]
    resources = [
      "${module.datalake_silver_accounts_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
    }
  }
}

data "aws_iam_policy_document" "datalake_gold_accounts_bucket" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }
    actions = [
      "s3:DeleteObject",
    ]
    resources = [
      "${module.datalake_gold_accounts_bucket.bucket_arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
    }
  }
}
