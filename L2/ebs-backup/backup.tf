data "aws_ebs_volumes" "volume_query" {
  filter {
    name   = "tag:${var.ebs_tags_name}"
    values = var.ebs_tags_value
  }
}

data "aws_ebs_volume" "volumes" {
  for_each = toset(data.aws_ebs_volumes.volume_query.ids)
  filter {
    name   = "volume-id"
    values = [each.value]
  }
}

resource "aws_iam_role" "ebs_aws_backup_role" {
  name = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeServiceRole"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ebs_aws_backup_service_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.ebs_aws_backup_role.name
}

resource "aws_backup_vault" "ebs_backup_vault" {
  kms_key_arn = var.kms_key_arn
  name        = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-vault"
  tags        = var.tags
}

resource "aws_backup_plan" "ebs_backup_plan" {
  name = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-plan"
  rule {
    rule_name         = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-rule-hourly"
    target_vault_name = aws_backup_vault.ebs_backup_vault.name
    schedule          = "cron(0 * * * ? *)"
    lifecycle {
      delete_after = 1
    }
  }
  rule {
    rule_name         = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-rule-daily"
    target_vault_name = aws_backup_vault.ebs_backup_vault.name
    schedule          = "cron(0 0 ? * * *)"
    lifecycle {
      delete_after = 7
    }
  }
  rule {
    rule_name         = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-rule-weekly"
    target_vault_name = aws_backup_vault.ebs_backup_vault.name
    schedule          = "cron(0 0 ? * SUN *)"
    lifecycle {
      delete_after = 30
    }
  }
  tags = var.tags
}

resource "aws_backup_selection" "ebs_backup_selection" {
  iam_role_arn = aws_iam_role.ebs_aws_backup_role.arn
  name         = "${join("-", compact([var.prefix, var.environment, var.component]))}-ebs-backup-selection"
  plan_id      = aws_backup_plan.ebs_backup_plan.id
  resources    = [for v in data.aws_ebs_volume.volumes : v.arn]
}
