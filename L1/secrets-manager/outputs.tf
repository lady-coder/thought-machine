output "secret_arns" {
  value = values(aws_secretsmanager_secret.this)[*].arn
}

output "secret_ids" {
  value = values(aws_secretsmanager_secret.this)[*].id
}

output "secret_names_and_strings_ids" {
  value = values(aws_secretsmanager_secret.secret)[*].id
}
