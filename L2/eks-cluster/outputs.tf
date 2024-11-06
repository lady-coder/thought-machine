
output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "eks_cluster_certificate_authority" {
  value     = aws_eks_cluster.this.certificate_authority[0].data
  sensitive = true
}

output "eks_cluster_id" {
  value = aws_eks_cluster.this.id
}

output "eks_control_plane_security_group_id" {
  value = aws_security_group.control_plane_sg.id
}

output "eks_cluster_security_group_id" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.this.arn
}

output "iam_openid_connect_provider_url" {
  value = aws_iam_openid_connect_provider.this.url
}

output "eks_cluster_oidc_issuer" {
  value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
