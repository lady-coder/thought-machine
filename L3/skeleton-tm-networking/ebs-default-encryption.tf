resource "aws_ebs_default_kms_key" "this" {
  key_arn = var.kms_ebs_arn
}

resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}
