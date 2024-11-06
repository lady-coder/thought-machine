variable "environment" {
  type        = string
  description = "Environment, for example sandbox or dev"
}

variable "cluster_name" {
  type        = string
  description = "Name of a cluster"
}

variable "kubernetes_version" {
  type    = string
  default = "1.23"
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "ID of vpc in which the cluster will be deployed"
}

variable "vpc_cird" {
  type        = string
  description = "CIDR of vpc in which the cluster will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of cluster subnets IDs. EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = []
  description = "List of cluster log types to be collected, possible options: api, audit, authenticator, controllerManager, scheduler"
}

variable "cluster_encryption_cmk_arn" {
  type        = string
  description = "ARN of KMS CMK used to encrypt the cluster"
}

variable "container_insights_log_group_cmk_arn" {
  type        = string
  description = "ContainerInsights Log Group CMK key ARN"
}

variable "container_insights_logs_retention_in_days" {
  type        = number
  description = "ContainerInsights Log Groups (cluster, application, platform) retention in days"
  default     = 3
}

variable "container_insights_metrics_retention_in_days" {
  type        = number
  description = "ContainerInsights Log Groups metrics(dataplane, host, performance, prometheus) retention in days"
  default     = 1
}

variable "log_group_prefix" {
  description = "Prefix for the related Cloudwatch log groups"
  type        = string
  default     = "/aws/eks"
}

variable "inbound_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be allowed to connect the eks cluster"
}

variable "k8s_logs_alert_medium_treshold_5minutes" {
  description = "the number of log error (medium level) should trigger the alarm in 5 minutes"
  type        = number
}

variable "k8s_logs_alert_high_treshold_5minutes" {
  description = "the number of log error (high level) should trigger the alarm in 5 minutes"
  type        = number
}

variable "k8s_logs_alert_superhigh_treshold_5minutes" {
  description = "the number of log error (superhigh level) should trigger the alarm in 5 minutes"
  type        = number
}

variable "filter_pattern" {
  description = "filter statement which indicates java ERROR logs produced by java spring boot applications"
  type        = string
  default     = "ERROR"
}

variable "sns_topic_arn" {
  description = "The ARN for the sns topic is using for sending alert"
  type        = string
}

variable "endpoint_public_access" {
  type        = bool
  description = "endpoint_public_access"
  default     = false
}

variable "control_plane_allowed_ip_ranges" {
  type        = list(string)
  default     = []
  description = "List of IP ranges to be allowed to connect the eks cluster"
}
