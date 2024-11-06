resource "aws_secretsmanager_secret" "this" {
  for_each                = toset(var.secret_names)
  name                    = each.value
  recovery_window_in_days = 0
  kms_key_id              = var.secretsmanager_cmk_arn
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_secretsmanager_secret" "secret" {
  for_each                = var.secrets
  name                    = each.key
  description             = "Secret key: ${each.key}."
  recovery_window_in_days = 0
  kms_key_id              = var.secretsmanager_cmk_arn
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_secretsmanager_secret_version" "secret" {
  for_each      = var.secrets
  secret_id     = aws_secretsmanager_secret.secret[each.key].id
  secret_string = each.value
}
