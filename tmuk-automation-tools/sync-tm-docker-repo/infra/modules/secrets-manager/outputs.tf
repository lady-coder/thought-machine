output "secret_arns" {
  value = values(aws_secretsmanager_secret.this)[*].arn
}

output "secret_ids" {
  value = values(aws_secretsmanager_secret.this)[*].id
}
