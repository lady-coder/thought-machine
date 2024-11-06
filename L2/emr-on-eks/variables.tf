variable "eks_cluster_id" {
  description = "EKS Cluster ID"
  type        = string
}

variable "create_emrcontainers_virtual_cluster" {
  description = "Determines whether a virtual cluster is created for EMR on EKS"
  type        = bool
  default     = true
}

variable "emr_on_eks_namespace" {
  description = "Namespace"
  type        = string
  default     = "emr-on-eks-spark"
}

variable "emr_on_eks_job_execution_role" {
  description = "Job execution role"
  type        = string
  default     = "emr-on-eks-job-role"
}

variable "emr_on_eks_additional_iam_policies" {
  description = "Additional IAM policies"
  type        = list(string)
  default     = []
}

variable "emr_service_name" {
  description = "EMR service name"
  type        = string
  default     = "emr-containers"
}

variable "emr_service_driver_name" {
  description = "EMR service driver name"
  type        = string
  default     = "emr-containers-sa-spark-driver"
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = "/"
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "eks_oidc_provider_url" {
  description = "EKS cluster IAM OIDC provider url"
  type        = string
}

variable "eks_cluster_arn" {
  description = "ARN of EKS cluster"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "account_id" {
  description = "Current AWS Account ID"
  type        = string
}
