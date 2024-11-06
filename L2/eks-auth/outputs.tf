
output "configmap_name" {
  value = kubernetes_config_map.aws_auth.metadata[0].name
}
