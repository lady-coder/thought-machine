variable "name" {
  type        = string
  description = "Name of glue table."
}

variable "database_name" {
  type        = string
  description = "Name of glue database."
}

variable "owner" {
  type        = string
  description = "Owner of glue table."
  default     = "hadoop"
}

variable "table_type" {
  type        = string
  description = "Type of table."
  default     = "EXTERNAL_TABLE"
}

variable "parameter_external" {
  type        = string
  description = "Is external table?"
  default     = "TRUE"
}

variable "avro_schema_literal_template_file_location" {
  type        = string
  description = "Avro schema literal template file location."
  default     = ""
}

variable "avro_schema_literal_name" {
  type        = string
  description = "Avro schema literal name."
  default     = ""
}

variable "avro_schema_literal_namespace" {
  type        = string
  description = "Avro schema literal namespace."
  default     = ""
}

variable "avro_schema_literal_name_value_name" {
  type        = string
  description = "Avro schema literal name value name."
  default     = ""
}

variable "avro_schema_literal_name_value_fields" {
  type        = string
  description = "Avro schema literal name value fields."
  default     = ""
}

variable "avro_schema_literal_value_fields" {
  type        = string
  description = "Avro schema literal value fields."
  default     = ""
}

variable "avro_schema_literal_key_name" {
  type        = string
  description = "Avro schema literal key name."
  default     = "id"
}

variable "avro_schema_literal_key_type" {
  type        = string
  description = "Avro schema literal key name."
  default     = "string"
}

variable "partition_keys" {
  type = list(object({
    name = string
    type = string
  }))
}

variable "location" {
  type        = string
  description = "Physical location of the table."
}

variable "input_format" {
  type        = string
  description = "Input format."
  default     = "org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat"
}

variable "output_format" {
  type        = string
  description = "Output format."
  default     = "org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat"
}

variable "ser_de_name" {
  type        = string
  description = "SerDe info name."
  default     = "AvroSerDe"
}

variable "serialization_library" {
  type        = string
  description = "Usually the class that implements the SerDe."
  default     = "org.apache.hadoop.hive.serde2.avro.AvroSerDe"
}

variable "columns" {
  type = list(object({
    name = string
    type = string
  }))
}

variable "classification" {
  type        = string
  description = "Classification."
  default     = "avro"
}

variable "serialization_format" {
  type        = string
  description = "Serialization format."
  default     = 1
}

variable "compressed" {
  type        = bool
  description = "Compressed."
  default     = false
}