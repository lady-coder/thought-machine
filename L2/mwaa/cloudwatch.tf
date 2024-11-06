resource "aws_cloudwatch_log_group" "mwaa" {
  for_each = var.mwaa_log_groups

  name       = "airflow-${var.mwaa_name}-${each.value}"
  kms_key_id = var.kms_cloudwatch_arn
  #checkov:skip=CKV_AWS_338: "Ensure CloudWatch log groups retains logs for at least 1 year"  
  retention_in_days = var.airflow_log_retention_days
}
