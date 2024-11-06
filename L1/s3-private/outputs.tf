output "bucket_domain_name" {
  description = "The s3 bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_id" {
  description = "The s3 bucket name"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The s3 bucket arn"
  value       = aws_s3_bucket.this.arn
}
