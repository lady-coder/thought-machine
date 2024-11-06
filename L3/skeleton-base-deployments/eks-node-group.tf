module "eks_node_group" {
  source  = "spacelift.io/gft-blx/eks-node-group/aws"
  version = "1.4.1"

  environment = var.environment
  region      = var.region
  name        = var.eks_cluster_name
  prefix      = var.prefix

  ami_type                     = var.ami_type
  ebs_optimized                = var.ebs_optimized
  aws_auth_configmap_name      = module.eks_auth.configmap_name
  eks_iam_node_group_role_name = local.eks_iam_node_group_role_name

  kubernetes_version = var.kubernetes_version
  node_groups        = var.node_groups
  eks_cluster_sg     = var.eks_control_plane_security_group_id
  eks_cluster_ca     = var.eks_cluster_certificate_authority
  eks_cluster_api    = var.eks_cluster_endpoint
}
