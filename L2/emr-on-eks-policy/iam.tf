data "aws_iam_policy_document" "emr_on_eks" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = var.bucket_arns
  }

  dynamic "statement" {
    for_each = (var.mwaa_name != null) ? [1] : [0]

    content {
      effect = "Allow"
      actions = [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents",
        "logs:GetLogEvents",
        "logs:GetLogRecord",
        "logs:GetLogGroupFields",
        "logs:GetQueryResults",
        "logs:DescribeLogStreams",
      ]
      resources = [
        "arn:aws:logs:${var.region}:${var.account_id}:log-group:airflow-${var.mwaa_name}-*"
      ]
    }
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
      "emr-containers:*",
    ]
    resources = [
      "arn:aws:emr-containers:${var.region}:${var.account_id}:/*"
    ]
  }
}

resource "aws_iam_policy" "emr_on_eks" {
  name        = "emr-job-iam-policies"
  description = "IAM policy for EMR on EKS Job execution"
  path        = "/"
  policy      = data.aws_iam_policy_document.emr_on_eks.json
}
