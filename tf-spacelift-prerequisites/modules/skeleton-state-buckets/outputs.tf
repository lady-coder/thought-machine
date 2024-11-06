output "s3_kms" {
  value = module.kms_s3.kms_key_arn
}

output "dynamodb_kms" {
  value = module.kms_db.kms_key_arn
}

output "dynamodb_state_file_networking_table" {
  value = module.dynamodb_state_file_networking.arn
}

output "dynamodb_state_file_infrastructure_table" {
  value = module.dynamodb_state_file_infrastructure.arn
}

output "s3_state_file_networking_bucket" {
  value = module.s3_state_file_networking.bucket_arn
}

output "s3_state_file_infrastructure_bucket" {
  value = module.s3_state_file_infrastructure.bucket_arn
}
