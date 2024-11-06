resource "aws_xray_encryption_config" "this" {
  count = var.xray_cmk_arn != "" ? 1 : 0

  type   = "KMS"
  key_id = var.xray_cmk_arn
}
