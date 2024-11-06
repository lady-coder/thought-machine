
resource "aws_msk_configuration" "this" {
  kafka_versions = [var.kafka_version]
  name           = "${var.cluster_name}-${local.dashed_version}-config"
  description    = "MSK Configuration for Cluster ${var.cluster_name} version ${var.kafka_version}."

  server_properties = local.apps_properties
}

resource "aws_msk_cluster" "this" {

  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = var.subnet_ids
    security_groups = [aws_security_group.broker_nodes.id]
    storage_info {
      ebs_storage_info {
        volume_size = var.broker_volume_size
      }
    }
    dynamic "connectivity_info" {
      for_each = var.enable_msk_configuration_public_access ? ["1"] : []
      content {
        public_access {
          type = "SERVICE_PROVIDED_EIPS"
        }
      }
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.this.arn
    revision = aws_msk_configuration.this.latest_revision
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }

    encryption_at_rest_kms_key_arn = var.msk_cmk_arn
  }

  client_authentication {
    sasl {
      iam   = var.client_authentication.iam
      scram = var.client_authentication.scram
    }
  }

  enhanced_monitoring = "PER_BROKER"

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.enable_broker_logs_export
        log_group = var.enable_broker_logs_export ? local.msk_brokers_log_group_name : ""
      }
    }
  }
}
