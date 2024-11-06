data "aws_caller_identity" "this" {}

data "aws_eks_cluster_auth" "this" {
  name = var.eks_cluster_id
}

locals {

  account_id = data.aws_caller_identity.this.account_id

  # do not edit these mappings
  eks_node_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/${var.eks_default_node_role}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:nodes", "system:bootstrappers"]
    }
  ]

  eks_jumphost_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/${var.admin_jumphost_iam_role_name}"
      username = "jumphost-cluster-admin-role"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/${var.aws_admin_role_name}"
      username = "aws-admin-role"
      groups   = ["system:masters"]
    }
    #   {
    #     rolearn  = "arn:aws:iam::${local.account_id}:role/${var.dev_jumphost_iam_role_name}"
    #     username = "jumphost-cluster-developer-role"
    #     groups   = ["${var.dev_jumphost_k8s_group_name}"]
    #   }
  ]

  aws_auth_data = distinct(
    concat(
      local.eks_node_roles,
      local.eks_jumphost_roles,
      var.eks_additional_roles
    )
  )

  # once yamlencode became stable switch to: yamlencode(local.aws_auth_data)
  aws_auth_data_raw = <<-EOT
    %{for role in local.aws_auth_data}
    - rolearn: ${role.rolearn}
      username: ${role.username}
      %{if length(role.groups) > 0}
      groups: %{for group in role.groups}
        - ${group} %{endfor}
      %{endif}
    %{endfor}
    EOT

  # convert human friendly (yaml) values
  aws_auth_data_yaml = indent(0, local.aws_auth_data_raw)
}
