output "eks_cluster_arn" {
  value = module.eks_cluster.eks_cluster_arn
}

output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}

output "eks_cluster_id" {
  value = module.eks_cluster.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks_cluster.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  value = module.eks_cluster.eks_cluster_certificate_authority
}

output "eks_cluster_security_group_id" {
  value = module.eks_cluster.eks_cluster_security_group_id
}

output "eks_jumphost_admin_security_group_id" {
  value = module.eks_jumphost_admin.jumphost_security_group_id
}

output "eks_control_plane_security_group_id" {
  value = module.eks_cluster.eks_control_plane_security_group_id
}

output "iam_openid_connect_provider_url" {
  value = module.eks_cluster.iam_openid_connect_provider_url
}

output "iam_openid_connect_provider_arn" {
  value = module.eks_cluster.iam_openid_connect_provider_arn
}

output "admin_jumphost_iam_role_name" {
  value = module.eks_jumphost_admin.jumphost_iam_role_name
}

output "admin_jumphost_iam_role_arn" {
  value = module.eks_jumphost_admin.jumphost_iam_role_arn
}

output "sns_metric_alert_topic_arn" {
  value       = aws_sns_topic.metric_alert.arn
  description = "ARN of SNS topic dedicated for metric alerts"
}

output "eks_cluster_oidc_issuer" {
  value = module.eks_cluster.eks_cluster_oidc_issuer
}
