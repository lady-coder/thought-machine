module "complyadvantage_mock_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = false

  scope            = "${var.environment}-${var.component}"
  namespace        = "complyadvantage-mock"
  application_name = "complyadvantage-mock"
}

resource "aws_iam_role_policy_attachment" "complyadvantage_mock_appmesh_envoy" {
  role       = module.complyadvantage_mock_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}
