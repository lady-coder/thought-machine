output "emr_on_eks_role_arn" {
  description = "IAM execution role ARN for EMR on EKS"
  value       = aws_iam_role.emr_on_eks_execution[*].arn
}

output "emr_on_eks_role_id" {
  description = "IAM execution role ID for EMR on EKS"
  value       = aws_iam_role.emr_on_eks_execution[*].id
}

output "emrcontainers_virtual_cluster_id" {
  description = "EMR Containers Virtual cluster ID"
  value       = aws_emrcontainers_virtual_cluster.emr_virtual_cluster[*].id
}
