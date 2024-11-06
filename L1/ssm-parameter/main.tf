resource "aws_ssm_parameter" "this" {
  name        = "/${var.environment}/${var.component}/${var.resource}/${var.parameter_name}"
  key_id      = var.cmk_key_id
  description = var.description
  type        = "SecureString"
  value       = var.value
}
