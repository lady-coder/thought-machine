locals {
  emr_on_eks_job_execution_role     = format("%s-%s", var.eks_cluster_id, var.emr_on_eks_job_execution_role)
  eks_oidc_issuer_url               = replace(var.eks_oidc_provider_url, "https://", "")
  eks_oidc_provider_arn             = "arn:aws:iam::${var.account_id}:oidc-provider/${local.eks_oidc_issuer_url}"
  emr_on_eks_job_execution_role_b36 = data.external.b36.result.value
}
