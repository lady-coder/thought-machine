
module "customer_iam_gateway_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "2.2.2"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn

  scope            = "${var.environment}-${var.component}"
  namespace        = "customer-iam-gateway"
  application_name = "customer-iam-gateway"

}

resource "aws_iam_role_policy_attachment" "customer_iam_gateway_appmesh_envoy" {
  role       = module.customer_iam_gateway_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

data "aws_iam_policy_document" "pingone_token" {
  statement {
    sid = "ReadWriteSecret"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecret",
      "secretsmanager:UpdateSecretVersionStage"
    ]
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:${var.region}:${local.account_id}:secret:/${var.environment}/${var.component}/digibank/customers/customer-iam-gateway/pingone-token*"]
  }
}

resource "aws_iam_policy" "pingone_token" {
  name   = "${var.environment}-${var.component}-pingone-token-policy"
  policy = data.aws_iam_policy_document.pingone_token.json
}

resource "aws_iam_role_policy_attachment" "customer_iam_gateway_pingone_token" {
  role       = module.customer_iam_gateway_irsa_role.irsa_role_name
  policy_arn = aws_iam_policy.pingone_token.arn
}
