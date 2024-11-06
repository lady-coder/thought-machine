locals {
  presto_view = jsonencode({
    originalSql = var.sql,
    catalog     = "awsdatacatalog",
    schema      = var.database_name,
    columns     = [for c in var.columns : { name = c.name, type = c.presto_type }],
  })
}