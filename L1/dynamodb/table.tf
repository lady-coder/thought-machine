resource "aws_dynamodb_table" "this" {
  #checkov:skip=CKV_AWS_28: "Ensure Dynamodb point in time recovery (backup) is enabled"
  name           = "${join("-", compact([var.prefix, var.env, var.component]))}-table"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  billing_mode   = var.billing_mode

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_key_arn
  }

  lifecycle {
    prevent_destroy = false
  }
}
