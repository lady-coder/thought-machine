output "name" {
  value = aws_glue_catalog_table.default.name
}
output "schema_literal_value" {
  value = var.ser_de_name == "AvroSerDe" ? aws_glue_catalog_table.default.parameters["avro.schema.literal"] : null
}