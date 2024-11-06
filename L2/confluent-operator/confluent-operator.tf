resource "kubernetes_namespace_v1" "namespace" {
  count = var.create && var.create_namespace ? 1 : 0

  metadata {
    annotations = var.namespace_annotations
    labels      = var.namespace_labels
    name        = var.namespace
  }
}

resource "helm_release" "confluent_operator" {
  count            = var.create ? 1 : 0
  name             = var.name
  namespace        = local.namespace
  create_namespace = false
  chart            = var.chart
  version          = var.chart_version
  repository       = var.repository
  values           = var.values
  wait_for_jobs    = var.wait_for_jobs

  dynamic "set" {
    for_each = var.set
    content {
      name  = set.value["name"]
      value = set.value["value"]
      type  = set.value["type"]
    }
  }

  dynamic "set_sensitive" {
    for_each = var.set_sensitive
    content {
      name  = set_sensitive.value["name"]
      value = set_sensitive.value["value"]
      type  = set_sensitive.value["type"]
    }
  }
}
