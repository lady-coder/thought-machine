data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "ChatbotAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "chatbot.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "deny_log_access" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint
  statement {
    effect = "Deny"

    actions = ["logs:*"]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_notificiations" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "deny_log_access" {
  name        = "${join("-", compact([var.prefix, var.environment, var.component]))}-deny-log-access-policy"
  path        = "/"
  description = "policy denying access for chatbot to log.*"
  policy      = data.aws_iam_policy_document.deny_log_access.json
}

resource "aws_iam_policy" "cloudwatch_notificiations" {
  name        = "${join("-", compact([var.prefix, var.environment, var.component]))}-cloudwatch-notifications-policy"
  path        = "/"
  description = "policy allowing chatbot to access cloudwatch resources required to send complete notifications"
  policy      = data.aws_iam_policy_document.cloudwatch_notificiations.json
}

resource "aws_iam_role" "this" {
  name               = "chatbot-${join("-", compact([var.prefix, var.environment, var.component]))}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "chatbot_role_notification_permissions" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.cloudwatch_notificiations.arn
}
