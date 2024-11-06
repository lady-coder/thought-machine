output "platform_secrets_kms" {
  value = module.kms_platform_secrets.kms_key_arn
}
