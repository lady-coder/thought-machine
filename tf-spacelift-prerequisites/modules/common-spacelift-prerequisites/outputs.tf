output "ecr_arn_list" {
  value = module.spacelift_ecr.ecr_arns
}

output "ecr_url" {
  value = module.spacelift_ecr.ecr_urls
}

output "ecr_registry_id" {
  value = module.spacelift_ecr.ecr_registry_ids
}

output "spacelift_kms" {
  value = module.kms_ecr.kms_key_arn
}
