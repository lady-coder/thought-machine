resource "random_string" "random" {
  count = var.role_name == null ? 1 : 0

  length  = 8
  lower   = true
  special = false
}

resource "aws_iam_role" "main" {
  count = var.repo != null ? 1 : 0

  name                 = "${lower(local.role_prefix)}-${lower(local.component_context)}-github-oidc"
  path                 = var.role_path
  permissions_boundary = var.role_permissions_boundary
  assume_role_policy   = data.aws_iam_policy_document.github_actions_assume_role_policy[0].json
  max_session_duration = var.role_max_session_duration
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = length(var.role_policy_arns)

  role       = join("", aws_iam_role.main[*].name)
  policy_arn = var.role_policy_arns[count.index]
}
