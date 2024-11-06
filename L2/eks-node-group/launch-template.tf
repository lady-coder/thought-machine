resource "aws_launch_template" "this" {
  #checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
  for_each               = var.node_groups
  name                   = lower("${var.name}-${each.key}-launch-template")
  ebs_optimized          = var.ebs_optimized
  update_default_version = true

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    B64_CLUSTER_CA     = var.eks_cluster_ca,
    API_SERVER_URL     = var.eks_cluster_api,
    K8S_CLUSTER_DNS_IP = "10.100.0.10",
    CLUSTER_NAME       = var.name,
    CAPACITY_TYPE      = each.value.capacity_type,
    NODEGROUP          = lower("${var.name}-${each.key}"),
    MAX_POD            = local.max_pod["${each.value.instance_types[0]}"],
  }))

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name
      dynamic "ebs" {
        for_each = flatten([lookup(block_device_mappings.value, "ebs", [])])
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  network_interfaces {
    security_groups = [var.eks_cluster_sg]
  }

  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = lower("${var.name}-${each.key}-worker")
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    http_protocol_ipv6          = "disabled"
    instance_metadata_tags      = "disabled"
  }
}
