resource "aws_codebuild_project" "this" {
  name         = "${local.name}-${var.phase}"
  description  = "CodeBuild project for ${local.name}-${var.phase}"
  service_role = aws_iam_role.codebuild_role.arn

  environment {
    compute_type    = var.compute_type
    type            = "LINUX_CONTAINER"
    image           = var.environment_image
    privileged_mode = true

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }
  }
  source {
    type      = "CODECOMMIT"
    location  = var.codecommit_repository_name
    buildspec = "buildspec_${var.phase}.yaml"
  }
  source_version = var.codecommit_branch
  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.vpc_subnets
    security_group_ids = [aws_security_group.this.id]
  }
  artifacts {
    type     = "S3"
    location = var.s3_artifacts
    name     = var.artifact_log_file
  }
  encryption_key = var.kms_key_arn
  logs_config {
    cloudwatch_logs {
      status     = var.logs_status
      group_name = aws_cloudwatch_log_group.this.name
    }
  }
  build_timeout = 180
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/codebuild/${local.name}-${var.phase}"
  retention_in_days = var.logs_retention_days
  kms_key_id        = var.cloudwatch_kms_arn
}

resource "aws_security_group" "this" {
  name        = "${local.name}-${var.phase}-sg"
  description = "Allow AWS CodeBuild access resources for egress traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
