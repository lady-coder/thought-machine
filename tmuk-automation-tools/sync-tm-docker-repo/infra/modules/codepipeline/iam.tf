resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-${local.name}-codepipeline-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_codecommit_policy" {
  name        = "codepipeline-codecommit-policy"
  description = "Allows CodePipeline to read data from CodeCommit"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GitPull",
          "codecommit:ListBranches",
          "codecommit:ListRepositories",
          "codecommit:UploadArchive",
          "codecommit:GetUploadArchiveStatus"
        ]
        Resource = ["arn:aws:codecommit:${var.region}:${local.account_id}:${var.source_repo_name}"]
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_codebuild_policy" {
  name        = "codepipeline-codebuild-policy"
  description = "Allows CodePipeline to access to CodeBuild"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codebuild:*"
        ]
        Resource = [for stage in var.stages : "arn:aws:codebuild:${var.region}:${local.account_id}:project/${local.name}-${stage.name}"]
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_s3_policy" {
  name        = "codepipeline-s3-policy"
  description = "Allows CodePipeline to retrieve and store S3 artifacts"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_artifacts}",
          "arn:aws:s3:::${var.s3_artifacts}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_kms_policy" {
  name        = "codepipeline-kms-policy"
  description = "Allows CodePipeline to access KMS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:DescribeKey",
          "kms:GenerateDataKey"
        ]
        Resource = [var.kms_key_arn]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_codecommit_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_codecommit_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_codebuild_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "codepipeline_s3_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_s3_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "codepipeline_kms_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_kms_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}
