output "kms_key" {
  value = aws_kms_key.this.id
}

output "kms_key_arn" {
  value = aws_kms_key.this.arn
}

output "kms_alias" {
  value = aws_kms_alias.this.name
}

output "kms_alias_arn" {
  value = aws_kms_alias.this.arn
}