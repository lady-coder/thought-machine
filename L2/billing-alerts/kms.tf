resource "aws_kms_key" "this" {
  provider = aws.billing

  description         = "KMS key to encrypt billing related services"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.combined_with_viaservice_condition.json
}

resource "aws_kms_alias" "this" {
  provider = aws.billing

  name          = "alias/${var.environment}-billing"
  target_key_id = aws_kms_key.this.key_id
}
