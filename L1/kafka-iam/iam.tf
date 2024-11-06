data "aws_iam_policy_document" "glue_access" {
  statement {
    effect = "Allow"
    actions = [
      "glue:CreateSchema",
      "glue:GetSchema",
      "glue:GetSchemaByDefinition",
      "glue:UpdateSchema",
    ]
    resources = concat(
      ["arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:registry/${var.glue_registry}"],
      local.schemas
    )
  }
  statement {
    effect = "Allow"
    actions = [
      "glue:GetSchemaVersion",
      "glue:GetSchemaVersionsDiff",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "kafka_rw_access" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:ReadData",
      "kafka-cluster:WriteData",
      "kafka-cluster:DescribeTopic"
    ]
    resources = local.readwrite_topics
  }
}

data "aws_iam_policy_document" "kafka_ro_access" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:ReadData",
      "kafka-cluster:DescribeTopic"
    ]
    resources = local.readonly_topics
  }
}

data "aws_iam_policy_document" "kafka_cluster" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster",
      "kafka-cluster:DescribeCluster",
      "kafka-cluster:WriteDataIdempotently",
      "kafka:DescribeCluster",
      "kafka:DescribeClusterV2",
      "kafka:DescribeConfiguration",
      "kafka:DescribeConfigurationRevision"
    ]
    resources = ["arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/${var.msk_cluster_name}/*"]
  }
}

data "aws_iam_policy_document" "kafka_groups" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:DescribeGroup",
      "kafka-cluster:AlterGroup"
    ]
    resources = ["arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:group/${var.msk_cluster_name}/*/*"]
  }
}

data "aws_iam_policy_document" "kafka_transactional_id" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:DescribeTransactionalId",
      "kafka-cluster:AlterTransactionalId"
    ]
    resources = ["arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:transactional-id/${var.msk_cluster_name}/*/*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role}"]
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = [
    length(local.schemas) > 0 ? data.aws_iam_policy_document.glue_access.json : "",
    length(local.readwrite_topics) > 0 ? data.aws_iam_policy_document.kafka_rw_access.json : "",
    length(local.readonly_topics) > 0 ? data.aws_iam_policy_document.kafka_ro_access.json : "",
    length(local.topics) > 0 ? data.aws_iam_policy_document.kafka_cluster.json : "",
    length(local.topics) > 0 ? data.aws_iam_policy_document.kafka_groups.json : "",
    length(local.topics) > 0 ? data.aws_iam_policy_document.kafka_transactional_id.json : "",
    var.allow_role_self_assume ? data.aws_iam_policy_document.assume_role.json : "",
  ]
}

resource "aws_iam_role_policy" "kafka_glue_access" {
  name   = "${var.policy_prefix}-kafka-glue-access"
  policy = data.aws_iam_policy_document.combined.json
  role   = var.role
}
