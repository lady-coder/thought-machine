data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id

  web_acl_name      = join("-", compact([var.prefix, var.environment, var.component, var.context]))
  component_context = join("-", compact([var.component, var.context]))
  s3_bucket_prefix  = "aws-waf-logs-${var.component}"

  managed_rules_enabled = [
    {
      name            = "AWSManagedRulesCommonRuleSet",
      priority        = 50
      override_action = "none"
      excluded_rules  = concat(["SizeRestrictions_BODY"], var.managed_rules_common_rules_excluded)
    },
    {
      name            = "AWSManagedRulesAmazonIpReputationList",
      priority        = 20
      override_action = "none"
      excluded_rules  = []
    },
    {
      name            = "AWSManagedRulesKnownBadInputsRuleSet",
      priority        = 60
      override_action = "none"
      excluded_rules  = []
    },
    {
      name            = "AWSManagedRulesSQLiRuleSet",
      priority        = 70
      override_action = "none"
      excluded_rules  = []
    },
    {
      name            = "AWSManagedRulesLinuxRuleSet",
      priority        = 80
      override_action = "none"
      excluded_rules  = var.managed_rules_linux_rules_excluded
    },
    {
      name            = "AWSManagedRulesUnixRuleSet",
      priority        = 90
      override_action = "none"
      excluded_rules  = []
    }
  ]
}
