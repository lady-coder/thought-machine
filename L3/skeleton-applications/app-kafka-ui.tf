module "kafka_ui_alb_prerequisites" {
  count = var.enable_kafka_ui ? 1 : 0

  source  = "spacelift.io/gft-blx/alb-prerequisites/aws"
  version = "1.0.6"

  environment = var.environment
  component   = var.component
  context     = "kafka-ui"
  region      = var.region

  vpc_id                          = var.vpc_id
  eks_workers_subnets_cidr_blocks = var.eks_workers_subnet_cidrs
  public_zone_id                  = data.aws_route53_zone.public.id
  domain_names                    = ["kfui.${var.public_domain_name}"]
  kms_s3_arn                      = var.s3_cmk_arn
  require_api_key                 = true
  api_key                         = data.aws_secretsmanager_secret_version.microservices_api_key.secret_string

  allowed_source_ips = [
    {
      cidr_blocks = var.microservices_ingress_allowed_ip_ranges
      description = "Allowed IP ranges"
    }
  ]
}

module "kafka_ui_irsa_role" {
  count = var.enable_kafka_ui ? 1 : 0

  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.6"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "kafka-ui"
  application_name = "kafka-ui"
}

resource "aws_iam_role_policy_attachment" "kafka_ui_appmesh_envoy" {
  count = var.enable_kafka_ui ? 1 : 0

  role       = module.kafka_ui_irsa_role[0].irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

resource "aws_iam_role_policy_attachment" "kafka_ui_msk" {
  count = var.enable_kafka_ui ? 1 : 0

  role       = module.kafka_ui_irsa_role[0].irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}

resource "aws_iam_role_policy_attachment" "kafka_ui_glue" {
  count = var.enable_kafka_ui ? 1 : 0

  role       = module.kafka_ui_irsa_role[0].irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueSchemaRegistryReadonlyAccess"
}

data "aws_iam_policy_document" "kafka_ui_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:*",
    ]
    resources = [
      "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*/*",
      "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:group/*/*/*",
      "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:topic/*/*/*",
      "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:transactional-id/*/*/*",
    ]
  }
}

resource "aws_iam_policy" "kafka_ui_policy" {
  count = var.enable_kafka_ui ? 1 : 0

  name   = "${var.environment}-${var.component}-kafka-ui-policy"
  policy = data.aws_iam_policy_document.kafka_ui_policy.json
}

resource "aws_iam_role_policy_attachment" "kafka_ui_policy" {
  count = var.enable_kafka_ui ? 1 : 0

  role       = module.kafka_ui_irsa_role[0].irsa_role_name
  policy_arn = aws_iam_policy.kafka_ui_policy[0].arn
}
