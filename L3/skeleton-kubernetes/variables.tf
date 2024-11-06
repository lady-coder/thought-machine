variable "region" {
  description = "Region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "component" {
  type        = string
  description = "Component"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the skeleton will be deployed"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC where the skeleton will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of cluster subnets IDs. EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane"
}

variable "kubernetes_version" {
  type    = string
  default = "1.23"
}

variable "kubectl_version" {
  type    = string
  default = "1.24.7"
}

variable "eks_jumphost_ec2_ami_id" {
  type = string
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

variable "eks_s3_cmk_arn" {
  type        = string
  description = "ARN of KMS CMK used to encrypt EKS related S3 buckets"
}

variable "sns_cmk_arn" {
  type        = string
  description = "SNS dedicated CMK key ARN"
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

variable "application_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs of the existing applications which are allowed to connect the eks cluster"
}

variable "k8s_logs_alert_medium_treshold_5minutes" {
  description = "The number of log error (medium level) should trigger the alarm in 5 minutes"
  type        = number
}

variable "k8s_logs_alert_high_treshold_5minutes" {
  description = "The number of log error (high level) should trigger the alarm in 5 minutes"
  type        = number
}

variable "k8s_logs_alert_superhigh_treshold_5minutes" {
  description = "The number of log error (superhigh level) should trigger the alarm in 5 minutes"
  type        = number
}

variable "filter_pattern" {
  description = "Filter statement which indicates java ERROR logs produced by java spring boot applications"
  type        = string
  default     = "ERROR"
}

variable "downscale_jumphost_after_working_hours" {
  default     = false
  type        = bool
  description = "Define if jumphost downscaling after working hours should be enabled"
}

variable "working_hours_start_cron" {
  type        = string
  description = "UTC time of the beginning of working hours"
}

variable "working_hours_end_cron" {
  type        = string
  description = "UTC time of the end of working hours"
}

variable "kms_cloudwatch_arn" {
  description = "ARN of CloudWatch KMS key"
  type        = string
}

variable "kms_lambda_arn" {
  description = "ARN of Lambda KMS key"
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

variable "prefix" {
  description = "Project prefix"
  type        = string
  default     = ""
}
