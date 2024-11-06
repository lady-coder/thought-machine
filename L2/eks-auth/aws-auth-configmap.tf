
resource "kubernetes_config_map" "aws_auth" {

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = local.aws_auth_data_yaml
    mapUsers = "" # obsolete - should not be in use - overriding to empty value
  }
}
