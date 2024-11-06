resource "aws_glue_registry" "this" {
  for_each = toset(var.glue_registry_names)

  description   = "Registry of schema in the AWS Glue Schema Registry for ${each.value} datasets"
  registry_name = each.value
}
