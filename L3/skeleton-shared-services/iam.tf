data "aws_iam_policy_document" "tm_api_key_access_policy" {
  statement {
    sid = "SecretsManager"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    effect    = "Allow"
    resources = [module.tm_api_secret.secret_arns[0]]
  }
}

resource "aws_iam_policy" "tm_api_key_access_policy" {
  name   = "${var.environment}-${var.component}-tm_api_key-access-policy"
  policy = data.aws_iam_policy_document.tm_api_key_access_policy.json
}
