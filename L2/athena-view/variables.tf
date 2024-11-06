variable "name" {
  type        = string
  description = "Name of glue view."
}

variable "database_name" {
  type        = string
  description = "Name of glue database."
}

variable "sql" {
  type        = string
  description = "Sql to load a view."
}

variable "columns" {
  type = list(object({
    name        = string
    type        = string
    presto_type = string
  }))
}