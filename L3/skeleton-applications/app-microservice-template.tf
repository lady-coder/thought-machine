
module "microservice_template_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "2.2.2"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn

  scope            = "${var.environment}-${var.component}"
  namespace        = "microservice-template"
  application_name = "microservice-template"

}

resource "aws_iam_role_policy_attachment" "microservice_template_appmesh_envoy" {
  role       = module.microservice_template_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "microservice_template_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.microservice_template_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "microservice-template"
  readwrite_topics = [
    "consume_topic",
    "produce_topic"
  ]
}

data "aws_iam_policy_document" "microservice_template_aurora" {
  statement {
    sid       = "RdsConnect"
    actions   = ["rds-db:connect"]
    effect    = "Allow"
    resources = ["arn:aws:rds-db:${var.region}:${local.account_id}:dbuser:${var.apps_aurora_cluster_resource_id}/microservice_template_iam_user"]
  }
}

resource "aws_iam_role_policy" "microservice_template_aurora" {
  name   = "microservice-template-aurora"
  policy = data.aws_iam_policy_document.microservice_template_aurora.json
  role   = module.microservice_template_irsa_role.irsa_role_name
}