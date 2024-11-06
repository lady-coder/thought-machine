data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = var.services
    content {
      effect  = "Allow"
      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = [statement.value]
      }
    }
  }
}

resource "aws_iam_role" "worker" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${var.environment}-${var.component}-private-worker-role"
}

resource "aws_iam_role_policy_attachment" "worker" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "worker" {
  depends_on = [aws_iam_role_policy_attachment.worker]

  name = "${var.environment}-${var.component}-private-worker-instance-profile"
  role = aws_iam_role.worker.name
}


#Role for lambda in charge to turn off the spacelift-workers
resource "aws_iam_role" "role_turn_off_spacelift_workers" {
  assume_role_policy = data.aws_iam_policy_document.lambda_turn_off_assumed_role.json
  name               = lower("${var.environment}-${var.component}-role-turn-off-spacelift-workers")
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

data "aws_iam_policy_document" "turn_off_spacelift_workers_policy" {
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

resource "aws_iam_policy" "turn_off_spacelift_workers_policy" {
  name   = "${var.environment}-${var.component}-turn-off-spacelift-workers-policy"
  policy = data.aws_iam_policy_document.turn_off_spacelift_workers_policy.json
}

resource "aws_iam_role_policy_attachment" "turn_off_spacelift_workers_policy" {
  role       = aws_iam_role.role_turn_off_spacelift_workers.name
  policy_arn = aws_iam_policy.turn_off_spacelift_workers_policy.arn
}

#Role for lambda in charge to turn on the spacelift-workers
resource "aws_iam_role" "role_turn_on_spacelift_workers" {
  assume_role_policy = data.aws_iam_policy_document.lambda_turn_on_assumed_role.json
  name               = lower("${var.environment}-${var.component}-role-turn-on-spacelift-workers")
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

data "aws_iam_policy_document" "turn_on_spacelift_workers_policy" {
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

resource "aws_iam_policy" "turn_on_spacelift_workers_policy" {
  name   = "${var.environment}-${var.component}-turn-on-spacelift-workers-policy"
  policy = data.aws_iam_policy_document.turn_on_spacelift_workers_policy.json
}

resource "aws_iam_role_policy_attachment" "turn_on_spacelift_workers_policy" {
  role       = aws_iam_role.role_turn_on_spacelift_workers.name
  policy_arn = aws_iam_policy.turn_on_spacelift_workers_policy.arn
}
