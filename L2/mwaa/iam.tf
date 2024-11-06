resource "aws_iam_role_policy" "secretsmanager" {
  count  = var.create_iam_role && var.create_secrets_manager_policy ? 1 : 0
  name   = format("%s-secretsmanager-policy", var.iam_role_name)
  policy = data.aws_iam_policy_document.secretsmanager[0].json
  role   = aws_iam_role.mwaa[0].id
}

data "aws_iam_policy_document" "secretsmanager" {
  count   = var.create_iam_role && var.create_secrets_manager_policy ? 1 : 0
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [
      "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.airflow_connections_path_prefix}/*",
      "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.airflow_variables_path_prefix}/*"
    ]
  }
}
