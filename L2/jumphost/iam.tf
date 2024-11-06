resource "aws_iam_role" "jumphost" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${local.name}-role"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "eks_describe_cluster" {
  statement {
    effect = "Allow"
    actions = [
      "eks:DescribeCluster"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "s3_kms_access" {
  statement {
    sid    = "S3KmsAccess"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
    resources = [
      var.kms_s3_arn
    ]
  }
}

resource "aws_iam_policy" "eks_describe_cluster" {
  name   = "${local.name}-eks-describe-cluster-policy"
  policy = data.aws_iam_policy_document.eks_describe_cluster.json
}

resource "aws_iam_policy" "s3_kms_access" {
  name   = "${local.name}-kms-s3-access-policy"
  policy = data.aws_iam_policy_document.s3_kms_access.json
}

resource "aws_iam_role_policy_attachment" "eks_describe_cluster" {
  role       = aws_iam_role.jumphost.name
  policy_arn = aws_iam_policy.eks_describe_cluster.arn
}

resource "aws_iam_role_policy_attachment" "s3_kms_access" {
  role       = aws_iam_role.jumphost.name
  policy_arn = aws_iam_policy.s3_kms_access.arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.jumphost.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "jumphost_ecr_read_only" {
  role       = aws_iam_role.jumphost.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "jumphost" {
  depends_on = [aws_iam_role_policy_attachment.ssm]

  name = "${local.name}-instance-profile"
  role = aws_iam_role.jumphost.name
}

#Role for lambda in charge to turn off the jumphost
resource "aws_iam_role" "role_turn_off_jumphost" {
  assume_role_policy = data.aws_iam_policy_document.lambda_turn_off_assumed_role.json
  name               = lower("${local.name}-role-turn-off-jumphost")
}

data "aws_iam_policy_document" "lambda_turn_off_assumed_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "scheduler.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "turn_off_jumphost_policy" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint  
  statement {
    sid = "CreateLogGroup"
    actions = [
      "logs:CreateLogGroup",
    ]
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    sid = "CWLogs"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    sid = "GetSsmSessions"
    actions = [
      "ssm:DescribeSessions"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "UpdateAsg"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:UpdateAutoScalingGroup"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "InvokeLambdaFromScheduler"
    actions = [
      "lambda:InvokeFunction"
    ]
    effect    = "Allow"
    resources = ["arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    sid = "SetLambdaInsideVpc"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "SetLambdaScheduler"
    actions = [
      "scheduler:*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "turn_off_jumphost_policy" {
  name   = "${local.name}-turn-off-jumphost-policy"
  policy = data.aws_iam_policy_document.turn_off_jumphost_policy.json
}

resource "aws_iam_role_policy_attachment" "turn_off_jumphost_policy" {
  role       = aws_iam_role.role_turn_off_jumphost.name
  policy_arn = aws_iam_policy.turn_off_jumphost_policy.arn
}

#Role for lambda in charge to turn on the jumphost
resource "aws_iam_role" "role_turn_on_jumphost" {
  assume_role_policy = data.aws_iam_policy_document.lambda_turn_on_assumed_role.json
  name               = lower("${local.name}-role-turn-on-jumphost")
}

data "aws_iam_policy_document" "lambda_turn_on_assumed_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "turn_on_jumphost_policy" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints" https://docs.bridgecrew.io/docs/ensure-iam-policies-do-not-allow-write-access-without-constraint
  statement {
    sid = "CreateLogGroup"
    actions = [
      "logs:CreateLogGroup",
    ]
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    sid = "CWLogs"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }

  statement {
    sid = "UpdateAsg"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:UpdateAutoScalingGroup"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "SetLambdaInsideVpc"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "turn_on_jumphost_policy" {
  name   = "${local.name}-turn-on-jumphost-policy"
  policy = data.aws_iam_policy_document.turn_on_jumphost_policy.json
}

resource "aws_iam_role_policy_attachment" "turn_on_jumphost_policy" {
  role       = aws_iam_role.role_turn_on_jumphost.name
  policy_arn = aws_iam_policy.turn_on_jumphost_policy.arn
}
