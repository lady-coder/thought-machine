resource "aws_athena_workgroup" "default" {

  name = var.workgroup_id

  configuration {
    bytes_scanned_cutoff_per_query     = var.bytes_scanned_cutoff_per_query
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled
    engine_version {
      selected_engine_version = var.athena_engine_version
    }

    result_configuration {
      encryption_configuration {
        encryption_option = var.workgroup_encryption_option
        kms_key_arn       = var.kms_key_arn
      }
      output_location = format("s3://%s/%s", var.s3_bucket_id, var.s3_output_path)
    }
  }

  force_destroy = var.workgroup_force_destroy
}