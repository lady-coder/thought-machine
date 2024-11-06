resource "aws_glue_catalog_table" "default" {
  name          = var.name
  database_name = var.database_name
  owner         = var.owner
  table_type    = var.table_type

  parameters = var.ser_de_name == "AvroSerDe" ? {
    EXTERNAL = var.parameter_external
    "avro.schema.literal" : trimspace(templatefile(
      var.avro_schema_literal_template_file_location,
      {
        avro_schema_literal_name              = var.avro_schema_literal_name,
        avro_schema_literal_namespace         = var.avro_schema_literal_namespace,
        avro_schema_literal_name_value_name   = var.avro_schema_literal_name_value_name,
        avro_schema_literal_name_value_fields = var.avro_schema_literal_name_value_fields
        avro_schema_literal_value_fields      = var.avro_schema_literal_value_fields
        avro_schema_literal_key_name          = var.avro_schema_literal_key_name
        avro_schema_literal_key_type          = var.avro_schema_literal_key_type
      }
    ))
    "classification"       = var.classification
    "serialization.format" = var.serialization_format
    } : {
    EXTERNAL               = var.parameter_external
    "classification"       = var.classification
    "serialization.format" = var.serialization_format
  }

  dynamic "partition_keys" {
    for_each = var.partition_keys
    content {
      name = partition_keys.value["name"]
      type = partition_keys.value["type"]
    }
  }

  storage_descriptor {
    location      = var.location
    input_format  = var.input_format
    output_format = var.output_format
    compressed    = var.compressed

    ser_de_info {
      name                  = var.ser_de_name
      serialization_library = var.serialization_library

      parameters = var.ser_de_name == "AvroSerDe" ? {
        "avro.schema.literal" : trimspace(templatefile(
          var.avro_schema_literal_template_file_location,
          {
            avro_schema_literal_name              = var.avro_schema_literal_name,
            avro_schema_literal_namespace         = var.avro_schema_literal_namespace,
            avro_schema_literal_name_value_name   = var.avro_schema_literal_name_value_name,
            avro_schema_literal_name_value_fields = var.avro_schema_literal_name_value_fields
            avro_schema_literal_value_fields      = var.avro_schema_literal_value_fields
            avro_schema_literal_key_name          = var.avro_schema_literal_key_name
            avro_schema_literal_key_type          = var.avro_schema_literal_key_type
          }
        ))
        "serialization.format" = var.serialization_format
        } : {
        "serialization.format" = var.serialization_format
      }
    }

    dynamic "columns" {
      for_each = var.columns
      content {
        name = columns.value["name"]
        type = columns.value["type"]
      }
    }
  }
}