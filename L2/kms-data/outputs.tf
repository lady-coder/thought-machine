output "kms_eks_arn" {
  value = module.kms_eks.kms_key_arn
}

output "kms_s3_eks" {
  value = module.kms_s3_eks.kms_key_arn
}

output "kms_secrets_manager_arn" {
  value = module.kms_secrets_manager.kms_key_arn
}

output "kms_cloudwatch_arn" {
  value = module.kms_cloudwatch.kms_key_arn
}

output "kms_sns_arn" {
  value = module.kms_sns.kms_key_arn
}
