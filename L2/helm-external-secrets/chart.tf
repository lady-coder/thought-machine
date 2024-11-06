
resource "helm_release" "external_secrets" {
  name  = "external-secrets"
  chart = "${path.module}/helm"

  namespace        = "external-secrets"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      environment                = var.environment,
      component                  = var.component,
      irsa_role_arn              = var.irsa_role_arn
      shared_services_account_id = var.shared_services_account_id
      region_ecr                 = var.region_ecr
      external_secrets_version   = var.external_secrets_version
    })
  ]
}
