resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-${local.name}-${var.phase}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_ec2_policy" {
  name        = "codebuild-${local.name}-${var.phase}-ec2-policy"
  description = "Allows CodeBuild to access EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:CreateNetworkInterfacePermission",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs"
        ]
        Resource = [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_logs_policy" {
  name        = "codebuild-${local.name}-${var.phase}-cloudwatch-logs-policy"
  description = "Allows CodeBuild to write logs to CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ]
        Resource = [
          "arn:aws:logs:${var.region}:${local.account_id}:*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_kms_policy" {
  name        = "codebuild-${local.name}-${var.phase}-kms-policy"
  description = "Allows CodeBuild to access KMS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:DescribeKey"
        ]
        Resource = [var.cloudwatch_kms_arn]
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_s3_policy" {
  name        = "codebuild-${local.name}-${var.phase}-s3-policy"
  description = "Allows CodeBuild to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${var.s3_artifacts}",
          "${var.s3_artifacts}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_ecr_policy" {
  name = "codebuild-${local.name}-${var.phase}-ecr-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:*"
        ]
        Resource = "arn:aws:ecr:${var.region}:${local.account_id}:repository/3rdparty/tm/*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_secret_policy" {
  name = "codebuild-${local.name}-${var.phase}-secret-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = var.codebuild_access_secret_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_ec2_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_ec2_policy.arn
  role       = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_logs_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_logs_policy.arn
  role       = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildReadOnlyAccess"
  role       = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_s3_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_s3_policy.arn
  role       = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_kms_attachment" {
  policy_arn = aws_iam_policy.codebuild_kms_policy.arn
  role       = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_ecr_policy.arn
  role       = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_secret_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_secret_policy.arn
  role       = aws_iam_role.codebuild_role.name
}
