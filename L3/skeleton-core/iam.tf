data "aws_iam_policy_document" "metric_alert_topic_policy" {

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "cloudwatch.amazonaws.com"
      ]
    }
    resources = [
      var.sns_metric_alert_topic_arn
    ]
  }
}

data "aws_iam_policy_document" "aurora_automations_apps" {
  #checkov:skip=CKV_AWS_108: "Ensure IAM policies does not allow data exfiltration" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-data-exfiltration
  statement {
    sid = "Parameters"
    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:*"]
  }
}

module "aurora_automations_iam_service_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "2.2.0"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  inline_policy                   = data.aws_iam_policy_document.aurora_automations_apps.json

  scope            = "${var.environment}-${var.component}"
  namespace        = "aurora-automations-apps"
  application_name = "aurora-automations-apps"

}

data "aws_iam_policy_document" "kafka_automations_apps" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  statement {
    sid = "AllowAppsMSKClusterAccess"
    actions = [
      "kafka-cluster:DescribeCluster",
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "AllowAppsMSKGroupOperations"
    actions = [
      "kafka-cluster:DescribeGroup",
      "kafka-cluster:AlterGroup"
    ]
    effect    = "Allow"
    resources = ["arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:group/*/*"]
  }
  statement {
    sid = "AllowAppsMSKTopicsRead"
    actions = [
      "kafka-cluster:ReadData",
      "kafka-cluster:*Topic*"
    ]
    effect    = "Allow"
    resources = ["arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:topic/*/*"]
  }
  statement {
    sid = "DenyAppsMSKTopicsDelete"
    actions = [
      "kafka-cluster:DeleteTopic"
    ]
    effect    = "Deny"
    resources = ["*"]
  }
}

module "kafka_automations_iam_service_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "2.2.2"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  inline_policy                   = data.aws_iam_policy_document.kafka_automations_apps.json

  scope            = "${var.environment}-${var.component}"
  namespace        = "kafka-automations-apps"
  application_name = "kafka-automations-apps"

}

data "aws_iam_policy_document" "msk_connection_policy" {
  statement {
    sid = "AllowAppsMSKClusterAccess"
    actions = [
      "kafka-cluster:DescribeCluster",
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster"
    ]
    effect    = "Allow"
    resources = [module.apps_kafka.cluster_arn]
  }
}

data "aws_iam_policy_document" "aurora_secret_access_policy" {
  statement {
    sid = "SecretsManager"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    effect    = "Allow"
    resources = [module.apps_aurora.master_password_secret_arn]
  }
}

resource "aws_iam_policy" "msk_connection_policy" {
  name   = "${var.environment}-${var.component}-jumphost-msk-connection-policy"
  policy = data.aws_iam_policy_document.msk_connection_policy.json
}

resource "aws_iam_policy" "aurora_secret_access_policy" {
  name   = "${var.environment}-${var.component}-aurora-secret-access-policy"
  policy = data.aws_iam_policy_document.aurora_secret_access_policy.json
}

resource "aws_iam_role_policy_attachment" "msk_connection_policy_for_jumphost" {
  role       = var.apps_jumphost_role_name
  policy_arn = aws_iam_policy.msk_connection_policy.arn
}

resource "aws_iam_role_policy_attachment" "aurora_secret_access_policy_for_worker_nodes" {
  role       = var.apps_cluster_worker_node_role_name
  policy_arn = aws_iam_policy.aurora_secret_access_policy.arn
}
