resource "aws_kms_key" "this" {
  description         = "KMS key to encrypt ${var.account_name} ${var.service_name}"
  enable_key_rotation = var.enable_key_rotation
  policy = length(var.service_principals_with_general_conditions) == 0 ? (
    length(var.services_principal) == 0 ? data.aws_iam_policy_document.general_policy.json : data.aws_iam_policy_document.combined_with_viaservice_condition.json
  ) : data.aws_iam_policy_document.combined_with_serviceprincipals_and_conditions.json
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.account_name}-${var.service_name}"
  target_key_id = aws_kms_key.this.key_id
}
