output "glue_registry_arn" {
  value = values(aws_glue_registry.this)[*].arn
}

output "glue_registry_id" {
  value = values(aws_glue_registry.this)[*].id
}
