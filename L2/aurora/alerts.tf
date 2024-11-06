locals {
  metric_writer = {
    CPUUtilization = {
      alarm_name          = "cpu-utilization-too-high"
      alarm_description   = "Average database CPU utilization over last 5 minutes too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "90" #Percent
    },
    FreeableMemory = {
      alarm_name          = "free-ram-too-small"
      alarm_description   = "Average available RAM over last 5 minutes is too low"
      comparison_operator = "LessThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "134217728" # 128MB
    },
    FreeLocalStorage = {
      alarm_name          = "local-storage-too-small"
      alarm_description   = "Average local storage available over last 5 minutes is too low"
      comparison_operator = "LessThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "536870912" # 512MB -> Bytes
    },
    ReadIOPS = {
      alarm_name          = "read-iops-too-high"
      alarm_description   = "Average ReadIOPS over last 5 minutes is too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "100" #Count/per secs
    },
    WriteIOPS = {
      alarm_name          = "write-iops-too-high"
      alarm_description   = "Average WriteIOPS operations per second over last 5 minutes is too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "100" #Count/per secs
    },
    NetworkThroughput = {
      alarm_name          = "network-throughput-too-low"
      alarm_description   = "Average NetworkThroughput available for the instance over last 5 minutes is too low"
      comparison_operator = "LessThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "0.5" #Count/per secs
    }
  }
  metric_reader = {
    DatabaseConnections = {
      alarm_name          = "too-many-db-connections"
      alarm_description   = "Average db connections over last 5 minutes is too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "${lookup(local.max_conn, var.instance_class) * var.max_conn_threshold}"
    },
    CPUUtilization = {
      alarm_name          = "cpu-utilization-too-high"
      alarm_description   = "Average database CPU utilization over last 5 minutes too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "90" #Percent
    },
    FreeableMemory = {
      alarm_name          = "free-ram-too-small"
      alarm_description   = "Average available RAM over last 5 minutes is too low"
      comparison_operator = "LessThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "134217728" # 128MB -> Bytes
    },
    FreeLocalStorage = {
      alarm_name          = "local-storage-too-small"
      alarm_description   = "Average local storage available over last 5 minutes is too low"
      comparison_operator = "LessThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "536870912" # 512MB -> Bytes
    },
    ReadIOPS = {
      alarm_name          = "read-iops-too-high"
      alarm_description   = "Average ReadIOPS over last 5 minutes is too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "100" #Count/per secs
    },
    AuroraReplicaLag = {
      alarm_name          = "replication-lag-too-big"
      alarm_description   = "Average the amount of lag when replicating updates from the primary instance over last 5 minutes is too high"
      comparison_operator = "GreaterThanThreshold"
      statistic           = "Average"
      evaluation_periods  = "1"
      period              = "300"
      threshold           = "120" # Milliseconds
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "writer" {
  for_each = merge(local.metric_writer, var.metric_alarm_aurora_writer)

  alarm_name          = "${var.environment}/platform/aurora/${var.cluster_identifier}/writer/${each.value.alarm_name}"
  alarm_description   = each.value.alarm_description
  metric_name         = each.key
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  period              = each.value.period
  threshold           = each.value.threshold
  statistic           = each.value.statistic

  namespace     = "AWS/RDS"
  alarm_actions = [var.sns_topic_arn]
  ok_actions    = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.this.id,
    Role                = "WRITER"
  }
}

resource "aws_cloudwatch_metric_alarm" "reader" {
  for_each = merge(local.metric_reader, var.metric_alarm_aurora_reader)

  alarm_name          = "${var.environment}/platform/aurora/${var.cluster_identifier}/reader/${each.value.alarm_name}"
  alarm_description   = each.value.alarm_description
  metric_name         = each.key
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  period              = each.value.period
  threshold           = each.value.threshold
  statistic           = each.value.statistic

  namespace     = "AWS/RDS"
  alarm_actions = [var.sns_topic_arn]
  ok_actions    = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.this.id,
    Role                = "READER"
  }
}
