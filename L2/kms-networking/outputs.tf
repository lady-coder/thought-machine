output "kms_ebs_arn" {
  value = module.kms_ebs.kms_key_arn
}

output "kms_s3_arn" {
  value = module.kms_s3.kms_key_arn
}

output "kms_cloudwatch_arn" {
  value = module.kms_cloudwatch.kms_key_arn
}

output "kms_xray_arn" {
  value = module.kms_xray.kms_key_arn
}

output "kms_lambda_arn" {
  value = module.kms_lambda.kms_key_arn
}
