output "datatech_platformtests_bucket_arn" {
  value = module.datatech_platformtests_bucket.bucket_arn
}

output "datatech_platformtests_bucket_id" {
  value = module.datatech_platformtests_bucket.bucket_id
}

output "datatech_airflowdags_bucket_arn" {
  value = module.datatech_airflowdags_bucket.bucket_arn
}

output "datatech_airflowdags_bucket_id" {
  value = module.datatech_airflowdags_bucket.bucket_id
}

output "datatech_sparkjobs_bucket_arn" {
  value = module.datatech_sparkjobs_bucket.bucket_arn
}

output "datatech_sparkjobs_bucket_id" {
  value = module.datatech_sparkjobs_bucket.bucket_id
}

output "datatech_athenaoutputs_bucket_arn" {
  value = module.datatech_athenaoutputs_bucket.bucket_arn
}

output "datatech_athenaoutputs_bucket_id" {
  value = module.datatech_athenaoutputs_bucket.bucket_id
}

output "datalake_customers_buckets_arns" {
  value = [
    module.datalake_bronze_customers_bucket.bucket_arn,
    module.datalake_silver_customers_bucket.bucket_arn,
    module.datalake_gold_customers_bucket.bucket_arn,
  ]
}

output "datalake_customers_buckets_ids" {
  value = [
    module.datalake_bronze_customers_bucket.bucket_id,
    module.datalake_silver_customers_bucket.bucket_id,
    module.datalake_gold_customers_bucket.bucket_id,
  ]
}

output "datalake_deposits_buckets_arns" {
  value = [
    module.datalake_bronze_deposits_bucket.bucket_arn,
    module.datalake_silver_deposits_bucket.bucket_arn,
    module.datalake_gold_deposits_bucket.bucket_arn,
  ]
}

output "datalake_deposits_buckets_ids" {
  value = [
    module.datalake_bronze_deposits_bucket.bucket_id,
    module.datalake_silver_deposits_bucket.bucket_id,
    module.datalake_gold_deposits_bucket.bucket_id,
  ]
}

output "datalake_accounts_buckets_arns" {
  value = [
    module.datalake_bronze_accounts_bucket.bucket_arn,
    module.datalake_silver_accounts_bucket.bucket_arn,
    module.datalake_gold_accounts_bucket.bucket_arn,
  ]
}

output "datalake_accounts_buckets_ids" {
  value = [
    module.datalake_bronze_accounts_bucket.bucket_id,
    module.datalake_silver_accounts_bucket.bucket_id,
    module.datalake_gold_accounts_bucket.bucket_id,
  ]
}
