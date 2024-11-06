locals {
  default_connector_values = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Connector
metadata:
  name: ${var.name}
  namespace: ${var.namespace}
spec:
  taskMax: 3
  connectClusterRef:
    name: connect
  EOF
  )
}
