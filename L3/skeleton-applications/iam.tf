data "aws_iam_policy_document" "glue_access_policy" {
  #checkov:skip=CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
  #checkov:skip=CKV_AWS_110: "Ensure IAM policies does not allow privilege escalation" https://docs.bridgecrew.io/docs/ensure-iam-policies-does-not-allow-privilege-escalation
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint

  statement {
    sid       = "AccessGlueRegistry"
    actions   = ["glue:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "glue_access_policy" {
  name   = "${var.environment}-${var.component}-glue-access-policy"
  policy = data.aws_iam_policy_document.glue_access_policy.json
}

resource "aws_iam_role_policy_attachment" "glue_access_policy_for_worker_nodes" {
  role       = var.apps_cluster_worker_node_role_name
  policy_arn = aws_iam_policy.glue_access_policy.arn
}
