output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster"
  value       = aws_msk_cluster.this.arn
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to Apache Zookeeper"
  value       = aws_msk_cluster.this.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "A comma separated list of one or more hostname:port pairs of Kafka brokers with TLS port"
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl" {
  description = "A comma separated list of one or more hostname:port pairs of Kafka brokers with SASL/SCRAM port"
  value       = aws_msk_cluster.this.bootstrap_brokers_sasl_scram
}

output "bootstrap_brokers_iam" {
  description = "A comma separated list of one or more hostname:port pairs of Kafka brokers with IAM port"
  value       = aws_msk_cluster.this.bootstrap_brokers_sasl_iam
}

output "msk_default_security_group_id" {
  description = "ID of security group attached to MSK"
  value       = aws_security_group.broker_nodes.id
}
