locals {
  metric_msk_broker = [
    {
      alarm_name          = "cluster-too-small-by-partitions"
      metric_name         = "PartitionCount"
      threshold           = "800" # Number
      period              = "300"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "Number of partitions used close to limits per broker. MSK might become unresponsive"
    },
    {
      alarm_name          = "disk-data-logs-used-too-high"
      metric_name         = "KafkaDataLogsDiskUsed"
      threshold           = "90" # Percent
      period              = "300"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK Broker Data Logs Disk Usage over last 5 minutes too high "
    },
    {
      alarm_name          = "disk-app-logs-used-too-high"
      metric_name         = "KafkaAppLogsDiskUsed"
      threshold           = "90" # Percent
      period              = "300"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK Broker App Logs Disk Usage over last 5 minutes too high "
    },
    {
      alarm_name          = "disk-root-used-too-high"
      metric_name         = "RootDiskUsed"
      threshold           = "90" # Percent
      period              = "300"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK Broker Root Disk Usage over last 5 minutes too high "
    },
    {
      alarm_name          = "client-connections-too-many"
      metric_name         = "ConnectionCount"
      threshold           = "2000" # MSK supports max of 3000 as per https://docs.aws.amazon.com/msk/latest/developerguide/limits.html
      period              = "300"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK Broker Connection Count over last 5 minutes too high. Users might be unable to connect to cluster"
    },
    {
      alarm_name          = "burstbalance-too-low"
      metric_name         = "BurstBalance"
      threshold           = "30" # Percent
      period              = "300"
      comparison_operator = "LessThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK Broker BurstBalance over last 5 minutes too low"
    },
    {
      alarm_name          = "zookeepersessions-greater-CONNECTED"
      metric_name         = "ZooKeeperSessionState"
      threshold           = "1" # Number
      period              = "300"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK ZooKeeperSessionState is greater than CONNECTED state"
    },
    {
      alarm_name          = "zookeepersessions-lower-CONNECTED"
      metric_name         = "ZooKeeperSessionState"
      threshold           = "1" # Number
      period              = "300"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = "1"
      statistic           = "Average"
      alarm_description   = "MSK ZooKeeperSessionState is lower than CONNECTED state"
    },
    {
      alarm_name          = "connection-creation-rate"
      metric_name         = "ConnectionCreationRate"
      threshold           = "15"
      period              = "300"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      statistic           = "Maximum"
      alarm_description   = "MSK Broker connection creation rate over last 5 minutes too high"
    },
  ]
  metric_alarm_msk_broker_cpu = [
    {
      alarm_name          = "cluster-too-small-by-cpu"
      threshold           = "60" # Percent
      period              = "600"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = "1"
      alarm_description   = "MSK Broker CPU User Usage over last 5 minutes too high"
    }
  ]
  metric_msk_cluster = [
    {
      alarm_name          = "ActiveControllerCount-greater-1"
      metric_name         = "ActiveControllerCount"
      threshold           = "1" # Number
      period              = "60"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = "2"
      datapoints_to_alarm = "2"
      statistic           = "Sum"
      alarm_description   = "MSK ActiveControllerCount is greater than 1. It should only one controller per cluster should be active at any given time."
    },
    {
      alarm_name          = "ActiveControllerCount-lower-1"
      metric_name         = "ActiveControllerCount"
      threshold           = "1" # Number
      period              = "60"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = "2"
      datapoints_to_alarm = "2"
      statistic           = "Sum"
      alarm_description   = "MSK ActiveControllerCount is lower than 1. It should	only one controller per cluster should be active at any given time."
    }
  ]
  metric_alarm_msk_broker  = concat(local.metric_msk_broker, var.alarm_msk_broker)
  metric_alarm_msk_cluster = concat(local.metric_msk_cluster, var.alarm_msk_cluster)
}

resource "aws_cloudwatch_metric_alarm" "general" {
  count               = length(local.metric_alarm_msk_broker) * var.number_of_broker_nodes
  alarm_name          = "${var.environment}/platform/msk/${var.cluster_name}/${(count.index % var.number_of_broker_nodes) + 1}/${local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["alarm_name"]}"
  comparison_operator = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["comparison_operator"]
  evaluation_periods  = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["evaluation_periods"]
  metric_name         = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["metric_name"]
  namespace           = "AWS/Kafka"
  period              = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["period"]
  statistic           = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["statistic"]
  threshold           = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["threshold"]
  alarm_description   = local.metric_alarm_msk_broker[floor(count.index / var.number_of_broker_nodes)]["alarm_description"]
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.cluster_name
    "Broker ID"    = (count.index % var.number_of_broker_nodes) + 1
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  count               = var.number_of_broker_nodes
  alarm_name          = "${var.environment}/platform/msk/${var.cluster_name}/${count.index + 1}/${local.metric_alarm_msk_broker_cpu[0]["alarm_name"]}"
  comparison_operator = local.metric_alarm_msk_broker_cpu[0]["comparison_operator"]
  evaluation_periods  = local.metric_alarm_msk_broker_cpu[0]["evaluation_periods"]
  threshold           = local.metric_alarm_msk_broker_cpu[0]["threshold"]
  alarm_description   = local.metric_alarm_msk_broker_cpu[0]["alarm_description"]
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  metric_query {
    id          = "cpu_usage"
    expression  = "cpu_user+cpu_system"
    label       = "CPU usage"
    return_data = "true"
  }

  metric_query {
    id = "cpu_user"

    metric {
      metric_name = "CpuSystem"
      namespace   = "AWS/Kafka"
      period      = local.metric_alarm_msk_broker_cpu[0]["period"]
      stat        = "Average"
      dimensions = {
        "Cluster Name" = var.cluster_name
        "Broker ID"    = count.index + 1
      }
    }
  }

  metric_query {
    id = "cpu_system"
    metric {
      metric_name = "CpuSystem"
      namespace   = "AWS/Kafka"
      period      = local.metric_alarm_msk_broker_cpu[0]["period"]
      stat        = "Average"
      dimensions = {
        "Cluster Name" = var.cluster_name
        "Broker ID"    = count.index + 1
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster" {
  count               = length(local.metric_alarm_msk_cluster)
  alarm_name          = "${var.environment}/platform/msk/${var.cluster_name}/${local.metric_alarm_msk_cluster[count.index]["alarm_name"]}"
  comparison_operator = local.metric_alarm_msk_cluster[count.index]["comparison_operator"]
  evaluation_periods  = local.metric_alarm_msk_cluster[count.index]["evaluation_periods"]
  datapoints_to_alarm = local.metric_alarm_msk_cluster[count.index]["datapoints_to_alarm"]
  metric_name         = local.metric_alarm_msk_cluster[count.index]["metric_name"]
  namespace           = "AWS/Kafka"
  period              = local.metric_alarm_msk_cluster[count.index]["period"]
  statistic           = local.metric_alarm_msk_cluster[count.index]["statistic"]
  threshold           = local.metric_alarm_msk_cluster[count.index]["threshold"]
  alarm_description   = local.metric_alarm_msk_cluster[count.index]["alarm_description"]
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.cluster_name
  }
}
