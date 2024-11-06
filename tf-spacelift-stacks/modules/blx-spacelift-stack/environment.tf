resource "spacelift_environment_variable" "region" {
  stack_id   = spacelift_stack.this.id
  name       = "TF_VAR_region"
  value      = var.region
  write_only = false
}

resource "spacelift_environment_variable" "environment" {
  stack_id   = spacelift_stack.this.id
  name       = "TF_VAR_environment"
  value      = var.environment
  write_only = false
}

resource "spacelift_environment_variable" "component" {
  stack_id   = spacelift_stack.this.id
  name       = "TF_VAR_component"
  value      = var.component
  write_only = false
}

resource "spacelift_environment_variable" "context" {
  stack_id   = spacelift_stack.this.id
  name       = "TF_VAR_context"
  value      = var.context
  write_only = false
}

# Only apply to shared-service-automation-github Spacelift stack
resource "spacelift_environment_variable" "github_app_id" {
  count = var.repository == "tf-automations-github" ? 1 : 0

  stack_id   = spacelift_stack.this.id
  name       = "GITHUB_APP_ID"
  value      = "to_be_updated_with_GITHUB_APP_ID"
  write_only = true

  lifecycle {
    ignore_changes = [value]
  }
}

resource "spacelift_environment_variable" "github_installation_id" {
  count = var.repository == "tf-automations-github" ? 1 : 0

  stack_id   = spacelift_stack.this.id
  name       = "GITHUB_APP_INSTALLATION_ID"
  value      = "to_be_updated_with_GITHUB_APP_INSTALLATION_ID"
  write_only = true

  lifecycle {
    ignore_changes = [value]
  }
}

resource "spacelift_environment_variable" "github_app_private_key" {
  count = var.repository == "tf-automations-github" ? 1 : 0

  stack_id   = spacelift_stack.this.id
  name       = "GITHUB_APP_PEM_FILE"
  value      = "to_be_updated_with_GITHUB_APP_PEM_FILE"
  write_only = true

  lifecycle {
    ignore_changes = [value]
  }
}

resource "spacelift_environment_variable" "github_owner" {
  count = var.repository == "tf-automations-github" ? 1 : 0

  stack_id   = spacelift_stack.this.id
  name       = "GITHUB_OWNER"
  value      = var.github_owner
  write_only = false
}
