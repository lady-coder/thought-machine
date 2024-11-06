output "ecr_arns" {
  value = values(aws_ecr_repository.this)[*].arn
}

output "ecr_urls" {
  value = values(aws_ecr_repository.this)[*].repository_url
}

output "ecr_registry_ids" {
  value = values(aws_ecr_repository.this)[*].registry_id
}
