module "eks_auth" {
  source  = "spacelift.io/gft-blx/eks-auth/aws"
  version = "1.0.9"

  eks_cluster_id                    = var.eks_cluster_id
  eks_cluster_endpoint              = var.eks_cluster_endpoint
  eks_cluster_certificate_authority = var.eks_cluster_certificate_authority

  eks_default_node_role = local.eks_iam_node_group_role_name

  admin_jumphost_iam_role_name = var.admin_jumphost_iam_role_name
  # dev_jumphost_iam_role_name   = "jumphost_dev_role_placeholder"

  aws_admin_role_name  = var.aws_admin_role_name
  eks_additional_roles = var.eks_additional_roles
}
