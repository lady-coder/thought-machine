
module "customer_phone_verification_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  allow_role_self_assume          = true

  scope            = "${var.environment}-${var.component}"
  namespace        = "customer-phone-verification-service"
  application_name = "customer-phone-verification-service"

}

resource "aws_iam_role_policy_attachment" "customer_phone_verification_service_appmesh_envoy" {
  role       = module.customer_phone_verification_service_irsa_role.irsa_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

module "customer_phone_verification_service_kafka" {
  source  = "spacelift.io/gft-blx/kafka-iam/aws"
  version = "1.1.4"

  region           = var.region
  role             = module.customer_phone_verification_service_irsa_role.irsa_role_name
  glue_registry    = var.microservices_glue_registry
  msk_cluster_name = local.msk_cluster_name
  policy_prefix    = "customer-phone-verification-service"
  readwrite_topics = [
    "customer.customer-service.checklist-step-update.v*",
    "onboarding.customer-service.customer-devices-status.v*",
    "shared.otp.create_otp.v*",
  ]
}
