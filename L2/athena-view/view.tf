resource "aws_glue_catalog_table" "default" {
  name          = var.name
  database_name = var.database_name
  table_type    = "VIRTUAL_VIEW"

  parameters = {
    "comment"     = "Presto View"
    "presto_view" = "true"
  }

  view_expanded_text = "/* Presto View */"
  view_original_text = "/* Presto View: ${base64encode(local.presto_view)} */"

  storage_descriptor {
    dynamic "columns" {
      for_each = var.columns
      content {
        name = columns.value.name
        type = columns.value.type
      }
    }

    ser_de_info {
      name                  = "-"
      serialization_library = "-"
    }
  }
}