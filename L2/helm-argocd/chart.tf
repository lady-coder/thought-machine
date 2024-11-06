resource "helm_release" "argocd" {
  name  = "argo-cd"
  chart = "${path.module}/helm"

  namespace        = var.namespace
  create_namespace = true

  values = [
    (var.enable_ui ?
      templatefile("${path.module}/values-ingress.yaml.tpl", {
        environment                = var.environment,
        region                     = var.region,
        component                  = var.component,
        shared_services_account_id = tostring(var.shared_services_account_id),
        subnetIDs                  = join(", ", var.public_subnet_ids),
        domainName                 = "argocd.${var.public_domain_name}",
        wafArn                     = module.alb_prerequisites[0].waf_arn,
        certificateArn             = module.alb_prerequisites[0].certificate_arn,
        githubOrg                  = trimprefix(var.github_org_url, "https://github.com/"),
        githubAppID                = var.github_app_id,
        githubAppInstallationID    = tostring(var.github_app_installation_id),
        githubAppPrivateKey        = "/${var.environment}/${var.component}/platform/argocd/github-app-private-key",
        githubOAuthAppClientID     = var.github_oauth_app_client_id,
        githubOAuthAppSecretName   = "/${var.environment}/${var.component}/platform/argocd/github-oauth-app-secret",
        repositories               = var.approvers_repository_access,
        securityGroup              = module.alb_prerequisites[0].alb_security_group_id,
        argocd_version             = var.argocd_version,
        redis_version              = var.redis_version,
        region_ecr                 = var.region_ecr
      })
      :
      templatefile("${path.module}/values-headless.yaml.tpl", {
        environment                = var.environment,
        region                     = var.region,
        region_ecr                 = var.region_ecr,
        component                  = var.component,
        shared_services_account_id = var.shared_services_account_id,
        argocd_version             = var.argocd_version,
        redis_version              = var.redis_version,
        githubAppID                = var.github_app_id,
        githubAppInstallationID    = tostring(var.github_app_installation_id),
        githubAppPrivateKey        = "/${var.environment}/${var.component}/platform/argocd/github-app-private-key"
      })
    )
  ]
}
