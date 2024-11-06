output "irsa_role_arn" {
  value = aws_iam_role.this.arn
}

output "irsa_role_name" {
  value = aws_iam_role.this.name
}

output "irsa_service_account_name" {
  value = local.service_account_name
}

output "irsa_application_name_to_arn_mapping" {
  value = {
    application_name = var.application_name
    role_arn         = aws_iam_role.this.arn
  }
}

output "irsa_application_name_to_role_name_mapping" {
  value = {
    application_name = var.application_name
    role_name        = aws_iam_role.this.name
  }
}
