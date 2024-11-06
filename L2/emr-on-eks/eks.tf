resource "kubernetes_namespace" "spark" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    annotations = {
      name = var.emr_on_eks_namespace
    }

    labels = {
      job-type = "spark"
    }

    name = var.emr_on_eks_namespace
  }
}

resource "kubernetes_role" "emr_containers" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    name      = var.emr_service_name
    namespace = var.emr_on_eks_namespace
  }

  rule {
    verbs      = ["get"]
    api_groups = [""]
    resources  = ["namespaces"]
  }

  rule {
    verbs      = ["get", "list", "watch", "describe", "create", "edit", "delete", "deletecollection", "annotate", "patch", "label"]
    api_groups = [""]
    resources  = ["serviceaccounts", "services", "configmaps", "events", "pods", "pods/log"]
  }

  rule {
    verbs      = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
    api_groups = [""]
    resources  = ["persistentvolumeclaims"]
  }

  rule {
    verbs      = ["create", "patch", "delete", "watch"]
    api_groups = [""]
    resources  = ["secrets"]
  }

  rule {
    verbs      = ["get", "list", "watch", "describe", "create", "edit", "delete", "annotate", "patch", "label"]
    api_groups = ["apps"]
    resources  = ["statefulsets", "deployments"]
  }

  rule {
    verbs      = ["get", "list", "watch", "describe", "create", "edit", "delete", "annotate", "patch", "label"]
    api_groups = ["batch"]
    resources  = ["jobs"]
  }

  rule {
    verbs      = ["get", "list", "watch", "describe", "create", "edit", "delete", "annotate", "patch", "label"]
    api_groups = ["extensions"]
    resources  = ["ingresses"]
  }

  rule {
    verbs      = ["get", "list", "watch", "describe", "create", "edit", "delete", "deletecollection", "annotate", "patch", "label"]
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["roles", "rolebindings"]
  }
}

resource "kubernetes_role_binding" "emr_containers" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    name      = var.emr_service_name
    namespace = kubernetes_namespace.spark[count.index].id
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = var.emr_service_name
    namespace = kubernetes_namespace.spark[count.index].id
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = var.emr_service_name
  }
}

resource "kubernetes_cluster_role" "emr_containers" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    name = var.emr_service_name
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "nodes"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "emr_containers" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    name = var.emr_service_name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.emr_service_name
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = var.emr_service_name
    namespace = kubernetes_namespace.spark[count.index].id
  }
}

resource "kubernetes_role" "emr_containers_driver" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    name      = var.emr_service_driver_name
    namespace = var.emr_on_eks_namespace
  }

  rule {
    verbs      = ["deletecollection"]
    api_groups = [""]
    resources  = ["configmaps"]
  }

  rule {
    verbs      = ["deletecollection"]
    api_groups = [""]
    resources  = ["persistentvolumeclaims"]
  }

  rule {
    verbs      = ["deletecollection"]
    api_groups = [""]
    resources  = ["pods"]
  }

  rule {
    verbs      = ["deletecollection"]
    api_groups = [""]
    resources  = ["services"]
  }
}

# https://docs.aws.amazon.com/emr/latest/EMR-on-EKS-DevelopmentGuide/iam-execution-role.html

resource "kubernetes_role_binding" "emr_containers_driver" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  metadata {
    name      = var.emr_service_driver_name
    namespace = kubernetes_namespace.spark[count.index].id
  }

  subject {
    kind      = "ServiceAccount"
    name      = "emr-containers-sa-spark-driver-${var.account_id}-${local.emr_on_eks_job_execution_role_b36}"
    namespace = kubernetes_namespace.spark[count.index].id
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = var.emr_service_driver_name
  }
}

# TODO Replace this resource once the provider is available for aws emr-containers
resource "null_resource" "update_trust_policy" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      AWS_DEFAULT_REGION = var.region
    }
    command = "set -e; aws emr-containers update-role-trust-policy --cluster-name ${var.eks_cluster_id} --namespace ${var.emr_on_eks_namespace} --role-name ${aws_iam_role.emr_on_eks_execution[count.index].name};"
  }
  triggers = {
    always_run = timestamp()
  }
  depends_on = [kubernetes_namespace.spark, aws_iam_role.emr_on_eks_execution]
}

resource "aws_emrcontainers_virtual_cluster" "emr_virtual_cluster" {
  count = var.create_emrcontainers_virtual_cluster ? 1 : 0

  name = "${var.eks_cluster_id}-${var.emr_on_eks_namespace}"

  container_provider {
    id   = var.eks_cluster_id
    type = "EKS"

    info {
      eks_info {
        namespace = var.emr_on_eks_namespace
      }
    }
  }
  depends_on = [null_resource.update_trust_policy]
}
