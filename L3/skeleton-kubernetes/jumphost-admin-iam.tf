resource "aws_iam_role_policy_attachment" "jumphost_S3_access_admin" {
  role       = module.eks_jumphost_admin.jumphost_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "jumphost_CW_access_admin" {
  role       = module.eks_jumphost_admin.jumphost_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

data "aws_iam_policy_document" "jumphost_additional_access_admin" {
  #checkov:skip=CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
  #checkov:skip=CKV_AWS_110: "Ensure IAM policies does not allow privilege escalation" https://docs.bridgecrew.io/docs/ensure-iam-policies-does-not-allow-privilege-escalation
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint

  statement {
    sid       = "RdsIamAuth"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:*"]
  }
  statement {
    sid       = "AccessGlueRegistry"
    actions   = ["glue:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "AllowAppsMSKClusterAccess"
    actions = [
      "kafka-cluster:*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "AssumeItselfAccess"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [module.eks_jumphost_admin.jumphost_iam_role_arn]
  }
}

resource "aws_iam_policy" "jumphost_additional_access_policy" {
  name   = "${var.environment}-${var.component}-jumphost-admin-additional-policy"
  policy = data.aws_iam_policy_document.jumphost_additional_access_admin.json
}

resource "aws_iam_role_policy_attachment" "jumphost_additional_access_policy_attachment" {
  role       = module.eks_jumphost_admin.jumphost_iam_role_name
  policy_arn = aws_iam_policy.jumphost_additional_access_policy.arn
}
