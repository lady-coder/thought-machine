# Create an IAM role to allow enhanced monitoring
data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0

  name_prefix        = "rds-enhanced-monitoring-"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0

  role       = aws_iam_role.rds_enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

#Role for lambdas in charge to turn on/off the dbs
resource "aws_iam_role" "role_turn_on_off_dbs" {
  assume_role_policy = data.aws_iam_policy_document.lambda_turn_on_off_assumed_role.json
  name               = lower("${var.environment}-${var.component}-role-turn-on-off-${var.cluster_identifier}")
}

data "aws_iam_policy_document" "lambda_turn_on_off_assumed_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "scheduler.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "turn_on_off_dbs_policy" {
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
    resources = ["arn:aws:autoscaling:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
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

  statement {
    sid = "permissionsoverdbs"
    actions = [
      "rds:StartDBCluster",
      "rds:StopDBCluster",
      "rds:ListTagsForResource",
      "rds:DescribeDBInstances",
      "rds:StopDBInstance",
      "rds:DescribeDBClusters",
      "rds:StartDBInstance"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "turn_on_off_dbs_policy" {
  name   = "${var.environment}-${var.component}-turn-on-off-${var.cluster_identifier}-policy"
  policy = data.aws_iam_policy_document.turn_on_off_dbs_policy.json
}

resource "aws_iam_role_policy_attachment" "turn_on_off_dbs_policy" {
  role       = aws_iam_role.role_turn_on_off_dbs.name
  policy_arn = aws_iam_policy.turn_on_off_dbs_policy.arn
}
