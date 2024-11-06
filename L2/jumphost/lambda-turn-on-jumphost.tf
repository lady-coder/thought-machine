module "turn_on_lambda_log_group" {
  source  = "spacelift.io/gft-blx/cloudwatch-log-group/aws"
  version = "1.0.1"

  log_group_name         = lower("/aws/lambda/${aws_lambda_function.lambda_turn_on_jumphost.function_name}")
  cloudwatch_kms_key_arn = var.kms_cloudwatch_arn
  retention_in_days      = var.retention_in_days
}

data "archive_file" "lambda_turn_on_jumphost" {
  type        = "zip"
  source_file = "${path.module}/python/lambda-turn-on-jumphost.py"
  output_path = "${path.module}/python/lambda-turn-on-jumphost.zip"
}

resource "aws_lambda_function" "lambda_turn_on_jumphost" {
  #checkov:skip=CKV_AWS_116: "Ensure AWS Lambda function is configured for a DLQ"
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint
  filename                       = "${path.module}/python/lambda-turn-on-jumphost.zip"
  function_name                  = lower("${local.name}-lambda-turn-on-jumphost")
  role                           = aws_iam_role.role_turn_on_jumphost.arn
  handler                        = "lambda-turn-on-jumphost.lambda_handler"
  runtime                        = "python3.8"
  reserved_concurrent_executions = var.reserved_concurrent_executions
  kms_key_arn                    = var.kms_lambda_arn

  tracing_config {
    mode = "Active"
  }

  vpc_config {
    subnet_ids         = var.vpc_subnets
    security_group_ids = [module.jumphost_autoscaling_group.security_group_id]
  }

  environment {
    variables = {
      ASG_NAME         = module.jumphost_autoscaling_group.autoscaling_group_name
      DESIRED_CAPACITY = var.desired_capacity
    }
  }
}
