resource "aws_eks_cluster" "this" {
  #checkov:skip=CKV_AWS_37: "Ensure Amazon EKS control plane logging enabled for all log types"
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.control_plane_role.arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.endpoint_public_access

    security_group_ids = [
      aws_security_group.control_plane_sg.id
    ]
  }
  encryption_config {
    provider {
      key_arn = var.cluster_encryption_cmk_arn
    }
    resources = ["secrets"]
  }

  tags = {
    "AWS.SSM.AppManager.EKS.Cluster.ARN" = "arn:aws:eks:${var.region}:${data.aws_caller_identity.this.account_id}:cluster/${var.cluster_name}"
  }
}

data "tls_certificate" "cluster_oidc_issuer" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.cluster_oidc_issuer.certificates.*.sha1_fingerprint
  url             = data.tls_certificate.cluster_oidc_issuer.url
}
