output "endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

output "master_password_secret_arn" {
  value = module.master_password_secret.secret_arns[0]
}

output "cluster_resource_id" {
  value = aws_rds_cluster.this.cluster_resource_id
}
