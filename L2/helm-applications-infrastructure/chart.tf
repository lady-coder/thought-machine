
resource "helm_release" "applications-infrastructure" {
  name  = "applications-infrastructure"
  chart = "${path.module}/helm"

  namespace        = var.namespace
  create_namespace = false

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      environment                = var.environment,
      namespace                  = var.namespace,
      githubOrgUrl               = var.github_org_url
      platformGitOpsRepoName     = var.platform_git_ops_repo_name
      applicationsGitOpsRepoName = var.applications_git_ops_repo_name
      infrastructure_path        = var.infrastructure_path
    })
  ]
}
