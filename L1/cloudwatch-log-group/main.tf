resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  kms_key_id        = var.cloudwatch_kms_key_arn
  retention_in_days = var.retention_in_days
}

/*
TODO Implement S3 or Glacier export to ensure logs persistence
*/
