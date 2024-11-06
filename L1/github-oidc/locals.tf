locals {
  account_id        = data.aws_caller_identity.current.account_id
  component_context = join("-", compact([var.component, var.context]))
  role_prefix       = join("-", compact([var.prefix, var.environment, local.account_id]))

  github_environments = (length(var.github_environments) > 0 && var.repo != null) ? [for e in var.github_environments : "repo:${var.repo}:environment:${e}"] : ["ensurethereisnotmatch"]

  variable_sub = "${var.github_oidc_issuer}:sub"

  default_allow_all = contains(var.default_conditions, "allow_all") ? [{
    test     = "StringLike"
    variable = local.variable_sub
    values   = ["repo:${var.repo}:*"]
  }] : []

  default_allow_main = contains(var.default_conditions, "allow_main") ? [{
    test     = "StringLike"
    variable = local.variable_sub
    values   = ["repo:${var.repo}:ref:refs/heads/main"]
  }] : []

  default_allow_environment = contains(var.default_conditions, "allow_environment") ? [{
    test     = "StringLike"
    variable = local.variable_sub
    values   = local.github_environments
  }] : []

  default_deny_pull_request = contains(var.default_conditions, "deny_pull_request") ? [{
    test     = "StringNotLike"
    variable = local.variable_sub
    values   = ["repo:${var.repo}:pull_request"]
  }] : []

  conditions = setunion(local.default_allow_main, local.default_allow_environment, local.default_allow_all, local.default_deny_pull_request, var.conditions)
  merge_conditions = [
    for k, v in { for c in local.conditions : "${c.test}|${c.variable}" => c... } : # group by test & variable
    {
      "test" : k,
      "values" : flatten([for index, sp in v[*].values : v[index].values if v[index].variable == v[0].variable]) # loop again to build the values inner map
    }
  ]

  root_principal_arns   = [for acc in var.account_ids : "arn:aws:iam::${acc}:root"]
  merged_principal_arns = concat(local.root_principal_arns, var.custom_principal_arns)
}
