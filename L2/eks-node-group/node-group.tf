resource "aws_eks_node_group" "this" {
  for_each = var.node_groups

  cluster_name           = var.name
  node_group_name_prefix = lower(join("-", compact([var.prefix, var.name, each.key])))
  node_role_arn          = aws_iam_role.this.arn
  subnet_ids             = each.value.subnet_ids
  ami_type               = lookup(each.value, "ami_type", var.ami_type)
  instance_types         = each.value.instance_types
  capacity_type          = each.value.capacity_type
  version                = var.kubernetes_version

  dynamic "taint" {
    for_each = each.value.kubernetes_taints
    content {
      key    = taint.value["key"]
      value  = taint.value["value"]
      effect = taint.value["effect"]
    }
  }

  launch_template {
    id      = aws_launch_template.this[each.key].id
    version = aws_launch_template.this[each.key].latest_version
  }

  scaling_config {
    desired_size = each.value.desired_capacity
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  labels = {
    "Name" = lower("${var.name}-${each.key}")
    "Type" = lower("${each.key}")
  }

  tags = {
    Environment                             = lower(var.environment)
    Name                                    = lower("${var.name}-${each.key}")
    "k8s.io/cluster-autoscaler/enabled"     = 1
    "k8s.io/cluster-autoscaler/${var.name}" = 1
  }

  lifecycle {
    # to prevent the destroy procedure running before creating when the instance types are changed
    create_before_destroy = true
    # This will be handled by cluster-autoscaler
    ignore_changes = [scaling_config.0.desired_size]
  }
}
