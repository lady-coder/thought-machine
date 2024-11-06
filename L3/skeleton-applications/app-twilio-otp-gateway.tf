
module "twilio_otp_gateway_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "twilio-otp-gateway"
  application_name = "twilio-otp-gateway"

}

resource "aws_iam_role_policy_attachment" "twilio_otp_gateway_appmesh_envoy" {
  role       = module.twilio_otp_gateway_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "twilio_otp_gateway_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.twilio_otp_gateway_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "twilio-otp-gateway"
  readwrite_topics = [
    "shared.otp.create_otp.v*",
  ]
}
