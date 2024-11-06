output "kms_eks_arn" {
  value = module.kms_eks.kms_key_arn
}

output "kms_s3_eks" {
  value = module.kms_s3_eks.kms_key_arn
}

output "kms_aurora_arn" {
  value = module.kms_aurora.kms_key_arn
}

output "kms_msk_arn" {
  value = module.kms_msk.kms_key_arn
}

output "kms_ssm_arn" {
  value = module.kms_ssm.kms_key_arn
}

output "kms_secrets_manager_arn" {
  value = module.kms_secrets_manager.kms_key_arn
}

output "kms_sns_arn" {
  value = module.kms_sns.kms_key_arn
}

output "kms_cloudwatch_arn" {
  value = module.kms_cloudwatch.kms_key_arn
}

output "kms_lambda_arn" {
  value = module.kms_lambda.kms_key_arn
}
