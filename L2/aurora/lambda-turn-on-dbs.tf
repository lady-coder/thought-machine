module "turn_on_dbs_lambda_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.1"

  log_group_name         = lower("/aws/lambda/${aws_lambda_function.lambda_turn_on_dbs.function_name}")
  cloudwatch_kms_key_arn = var.cloudwatch_cmk_arn
  retention_in_days      = var.retention_in_days
}

data "archive_file" "lambda_turn_on_dbs" {
  type        = "zip"
  source_file = "${path.module}/python/lambda-turn-on-off-dbs.py"
  output_path = "${path.module}/python/lambda-turn-on-dbs.zip"
}

resource "aws_lambda_function" "lambda_turn_on_dbs" {
  #checkov:skip=CKV_AWS_116: "Ensure AWS Lambda function is configured for a DLQ"
  #checkov:skip=CKV_AWS_173: "Check encryption settings for Lambda environmental variable"
  #checkov:skip=CKV_AWS_272: "Ensure AWS Lambda function is configured to validate code-signing"
  filename                       = "${path.module}/python/lambda-turn-on-dbs.zip"
  function_name                  = lower("${var.environment}-${var.component}-lambda-turn-on-${var.cluster_identifier}")
  role                           = aws_iam_role.role_turn_on_off_dbs.arn
  handler                        = "lambda-turn-on-off-dbs.lambda_handler"
  runtime                        = "python3.8"
  reserved_concurrent_executions = var.reserved_concurrent_executions
  kms_key_arn                    = var.kms_lambda_arn

  tracing_config {
    mode = "Active"
  }

  vpc_config {
    subnet_ids         = var.lambdas_subnets
    security_group_ids = [aws_security_group.lambdas_turn_on_off_sg.id]
  }

  environment {
    variables = {
      STATE_TAG = "blx:autostart"
    }
  }
}
