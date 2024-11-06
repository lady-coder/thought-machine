output "arn" {
  description = "List of newly created Athena databases."
  value       = aws_glue_catalog_database.default.arn
}

output "name" {
  description = "Name of newly created Athena databases."
  value       = aws_glue_catalog_database.default.name
}