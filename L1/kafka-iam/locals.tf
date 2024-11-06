data "aws_caller_identity" "current" {}

locals {
  topics = concat(var.readwrite_topics, var.readonly_topics)
  schemas = [
    for schema in local.topics : "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:schema/${var.glue_registry}/${schema}"
  ]
  readonly_topics = [
    for topic in var.readonly_topics : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:topic/${var.msk_cluster_name}/*/${topic}"
  ]
  readwrite_topics = [
    for topic in var.readwrite_topics : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:topic/${var.msk_cluster_name}/*/${topic}"
  ]
}
