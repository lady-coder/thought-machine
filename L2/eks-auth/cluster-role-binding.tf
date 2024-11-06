resource "kubernetes_cluster_role_binding" "readonly_access_for_dev_jumphosts" {
  metadata {
    name = "cluster-viewer-readonly"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }
  subject {
    kind = "Group"
    name = var.dev_jumphost_k8s_group_name
  }
}

resource "kubernetes_cluster_role_binding" "view_custom_api_groups_for_dev_jumphosts" {
  metadata {
    name = "cluster-viewer-view-custom-api-groups"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view-custom-api-groups"
  }
  subject {
    kind = "Group"
    name = var.dev_jumphost_k8s_group_name
  }
}

resource "kubernetes_cluster_role_binding" "view_built_in_api_groups_for_dev_jumphosts" {
  metadata {
    name = "cluster-viewer-view-built-in-api-groups"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view-built-in-api-groups"
  }
  subject {
    kind = "Group"
    name = var.dev_jumphost_k8s_group_name
  }
}

resource "kubernetes_cluster_role_binding" "view_built_in_ungrouped_resources_for_dev_jumphosts" {
  metadata {
    name = "cluster-viewer-view-built-in-ungrouped-resources"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view-built-in-ungrouped-resources"
  }
  subject {
    kind = "Group"
    name = var.dev_jumphost_k8s_group_name
  }
}
