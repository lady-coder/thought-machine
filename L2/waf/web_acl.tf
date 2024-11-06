
resource "aws_wafv2_web_acl" "default" {
  #checkov:skip=CKV_AWS_192: "Ensure WAF prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell"

  name        = local.web_acl_name
  description = "WAFv2 ACL for ${local.web_acl_name}"
  scope       = "REGIONAL"
  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = local.web_acl_name
  }

  custom_response_body {
    content = jsonencode(
      {
        access = "denied"
    })
    content_type = "APPLICATION_JSON"
    key          = "deny"
  }

  dynamic "rule" {
    for_each = var.require_api_key == true ? [1] : []
    content {
      name     = "block-x-api-key-miss"
      priority = 5
      action {
        block {
          custom_response {
            custom_response_body_key = "deny"
            response_code            = 404
          }
        }
      }
      statement {
        not_statement {
          statement {
            byte_match_statement {
              positional_constraint = "EXACTLY"
              search_string         = var.api_key
              field_to_match {
                single_header {
                  name = "x-api-key"
                }
              }
              text_transformation {
                priority = 0
                type     = "NONE"
              }
            }
          }
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "block-x-api-key-miss"
        sampled_requests_enabled   = true
      }
    }
  }

  dynamic "rule" {
    for_each = aws_wafv2_rule_group.rule_group_block_country
    content {
      name     = "group-rule-block-country"
      priority = 10
      override_action {
        none {}
      }
      statement {
        rule_group_reference_statement {
          arn = aws_wafv2_rule_group.rule_group_block_country[count.index].arn
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "group-rule-block-country"
        sampled_requests_enabled   = true
      }
    }
  }

  rule {
    name     = "ip-rate-based-limit-rule"
    priority = 30
    action {
      count {}
    }
    statement {
      rate_based_statement {
        limit              = var.ip_rate_based_limit_per_5min
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "ip-rate-based-limit-rule"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "max-payload-size-in-byte-rule"
    priority = 40
    action {
      block {}
    }

    statement {
      size_constraint_statement {
        text_transformation {
          type     = "NONE"
          priority = 5
        }
        comparison_operator = "GT"
        size                = var.max_payload_size_in_bytes
        field_to_match {
          body {}
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "max-payload-size-in-byte-rule"
      sampled_requests_enabled   = true
    }
  }

  dynamic "rule" {
    for_each = local.managed_rules_enabled
    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        dynamic "none" {
          for_each = rule.value.override_action == "none" ? [1] : []
          content {}
        }

        dynamic "count" {
          for_each = rule.value.override_action == "count" ? [1] : []
          content {}
        }
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = "AWS"

          dynamic "rule_action_override" {
            for_each = rule.value.excluded_rules
            content {
              name = rule_action_override.value
              action_to_use {
                count {}
              }
            }
          }
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  dynamic "rule" {
    for_each = length(var.allowed_paths) > 0 ? [1] : []
    content {
      name     = "group-rule-block-unaccepted-paths"
      priority = 101
      override_action {
        none {}
      }

      statement {
        rule_group_reference_statement {
          arn = aws_wafv2_rule_group.rule_group_block_unaccepted_paths[0].arn
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "group-rule-block-unaccepted-paths"
        sampled_requests_enabled   = true
      }
    }
  }

}

resource "aws_wafv2_web_acl_logging_configuration" "default_logging_s3" {
  count = var.enable_logging ? 1 : 0

  log_destination_configs = [module.waf_log_bucket.bucket_arn]
  resource_arn            = aws_wafv2_web_acl.default.arn

}
