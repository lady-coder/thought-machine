locals {
  execution_role_arn = var.create_iam_role ? aws_iam_role.mwaa[0].arn : var.execution_role_arn

  default_airflow_configuration_options = {
    "logging.logging_level" = "INFO"
  }

  airflow_configuration_options = merge(local.default_airflow_configuration_options, var.airflow_configuration_options)

  iam_role_additional_policies = { for k, v in toset(concat([var.iam_role_additional_policies])) : k => v if var.execution_role_arn != null }

  eks_oidc_issuer_url = replace(var.eks_oidc_provider_url, "https://", "")

  eks_oidc_provider_arn = "arn:aws:iam::${var.account_id}:oidc-provider/${local.eks_oidc_issuer_url}"
}
