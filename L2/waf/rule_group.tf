
resource "aws_wafv2_rule_group" "rule_group_block_country" {
  count    = length(var.blocked_countries) > 0 ? 1 : 0
  name     = "${local.web_acl_name}-rule-group-block-country"
  scope    = "REGIONAL"
  capacity = 2

  rule {
    name     = "rule-group-block-country"
    priority = 1
    action {
      allow {}
    }

    statement {
      geo_match_statement {
        country_codes = var.blocked_countries
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.web_acl_name}-rule-group-block-country"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.web_acl_name}-rule-group"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_rule_group" "rule_group_block_unaccepted_paths" {
  count    = length(var.allowed_paths) > 0 ? 1 : 0
  name     = "${local.web_acl_name}-rule-group-block-unaccepted-paths"
  scope    = "REGIONAL"
  capacity = 60

  custom_response_body {
    content = jsonencode(
      {
        access = "Access denied"
    })
    content_type = "APPLICATION_JSON"
    key          = "access_denied"
  }

  rule {
    name     = "block-unaccepted-paths"
    priority = 100

    action {
      block {
        custom_response {
          custom_response_body_key = "access_denied"
          response_code            = 404
        }
      }
    }

    statement {
      not_statement {
        statement {
          or_statement {
            dynamic "statement" {
              for_each = var.allowed_paths

              content {
                byte_match_statement {
                  positional_constraint = "STARTS_WITH"
                  search_string         = statement.value

                  field_to_match {
                    uri_path {}
                  }

                  text_transformation {
                    priority = 1
                    type     = "LOWERCASE"
                  }
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.web_acl_name}-rule-group-block-unaccepted-paths"
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.web_acl_name}-rule-group-block-paths"
    sampled_requests_enabled   = true
  }
}
