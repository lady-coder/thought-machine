variable "eks_cluster_id" {
  type        = string
  description = "ID of EKS cluster"
}

variable "eks_cluster_endpoint" {
  type        = string
  description = "Endpoint of EKS cluster"
}

variable "eks_cluster_certificate_authority" {
  type        = string
  description = "CA certificate of EKS cluster"
}

variable "eks_default_node_role" {
  type        = string
  description = "IAM Role used by standard EKS worker nodes"
}

variable "admin_jumphost_iam_role_name" {
  type        = string
  default     = "jumphost-admin-role"
  description = "IAM Role used by jumphosts dedicated for administrators"
}

variable "dev_jumphost_iam_role_name" {
  type        = string
  default     = "jumphost-dev-role"
  description = "IAM Role used by jumphosts dedicated for developers"
}

variable "aws_admin_role_name" {
  type        = string
  description = "IAM Role used by AWS SSO admin users"
}

variable "dev_jumphost_k8s_group_name" {
  type        = string
  default     = "jumphost:developers"
  description = "Name of the K8S group to be used by the developers"
}

variable "eks_additional_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "Additional IAM roles to add to the aws-auth ConfigMap"
}
