
# These api groups are not included in the default cluster-viewer permission scope
resource "kubernetes_cluster_role" "view_custom_api_groups" {
  #checkov:skip=CKV_K8S_49: "Minimize wildcard use in Roles and ClusterRoles"
  metadata {
    name = "view-custom-api-groups"
  }
  rule {
    api_groups = [
      # cert-manager
      "acme.cert-manager.io",
      "cert-manager.io",
      # aws-vpc-cni
      "crd.k8s.amazonaws.com",
      # prometheus
      "monitoring.coreos.com",
    ]
    resources = ["*"]
    verbs     = ["get", "list", "watch"]
  }
}

# These api groups are not included in the default cluster-viewer permission scope
resource "kubernetes_cluster_role" "view_built_in_api_groups" {
  #checkov:skip=CKV_K8S_49: "Minimize wildcard use in Roles and ClusterRoles"
  metadata {
    name = "view-built-in-api-groups"
  }
  rule {
    api_groups = [
      # admission webhooks
      "admissionregistration.k8s.io",
      # customresourcedefinitions
      "apiextensions.k8s.io",
      # policy - psp, pdb etc.
      "policy",
      # rbac - clusterrole, rolebindings etc.
      "rbac.authorization.k8s.io",
      # priority class
      "scheduling.k8s.io",
      # storage class
      "storage.k8s.io",
    ]
    resources = ["*"]
    verbs     = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role" "view_built_in_ungrouped_resources" {
  metadata {
    name = "view-built-in-ungrouped-resources"
  }
  rule {
    api_groups = [""]
    resources = [
      "nodes",
      "persistentvolumes",
      "podtemplates",
    ]
    verbs = ["get", "list", "watch"]
  }
}
