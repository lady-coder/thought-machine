variable "environment" {
  type        = string
  description = "environment"
}

variable "component" {
  type        = string
  description = "Component"
}

variable "region" {
  type        = string
  description = "Region in which the resources will be deployed"
}

variable "aws_admin_role_name" {
  type        = string
  description = "IAM Role used by AWS SSO admin users"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the resources will be deployed"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC where the resources will be deployed"
}

variable "enable_broker_logs_export" {
  description = "Enable export of MSK broker logs to Cloudwatch log group"
  type        = bool
  default     = true
}

variable "kafka_broker_instance_type" {
  type        = string
  description = "Kafka broker instance type"
}

variable "kafka_client_authentication" {
  type = object({
    iam   = bool
    scram = bool
  })
  description = "Kafka client authentication: SCRAM, IAM"
}

variable "aurora_instance_class" {
  type        = string
  description = "Aurora instance class"
}

variable "aurora_number_of_instances" {
  description = "Aurora number of instances"
  type        = number
}

variable "aurora_preferred_maintenance_window" {
  description = "The window to perform maintenance on Aurora"
  type        = string
}

variable "aurora_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable enhanced monitoring, specify 0, otherwise set 1, 5, 10, 15, 30 or 60"
  type        = number
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnets IDs"
}

variable "db_subnet_ids" {
  type        = list(string)
  description = "List of database subnets IDs"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnets IDs"
}

variable "public_domain_name" {
  type        = string
  description = "Public domain name for which the ACM certificates will be generated"
}

variable "kubernetes_cluster_version" {
  type = string
}

variable "kubernetes_nodegroups_version" {
  type = string
}

variable "kubectl_version" {
  type = string
}

variable "eks_jumphost_ec2_ami_id" {
  type = string
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

variable "github_org_url" {
  description = "Github organization URL"
  type        = string
}

variable "platform_git_ops_repo_name" {
  description = "Name of GitOps repository containing configurations of all platform applications"
  type        = string
}

variable "applications_git_ops_repo_name" {
  description = "Name of GitOps repository containing configurations of all microservices and automation applications"
  type        = string
}
/**
variable "github_pat_owner_username" {
  description = "Username of a Github PAT owner"
  type        = string
}

variable "argocd_github_app_client_id" {
  description = "ID of a GitHub ArgoCD app"
  type        = string
}
*/

variable "argocd_github_app_id" {
  description = "ID of a ArgoCD GitHub App"
  type        = string
  default     = ""
}

variable "argocd_github_app_installation_id" {
  description = "Installation ID of a ArgoCD GitHub App"
  type        = string
  default     = ""
}

variable "argocd_github_oauth_app_client_id" {
  description = "Client ID of a ArgoCD GitHub OAuth App"
  type        = string
  default     = ""
}

variable "argocd_version" {
  description = "ArgoCD application version"
  type        = string

  default = ""
}

variable "redis_version" {
  description = "Redis application version"
  type        = string

  default = ""
}

variable "external_secrets_version" {
  type        = string
  description = "external_secrets_version"
}

variable "billing_alert_subscriber_emails" {
  description = "The email addresses of subscribers of billing alerts."
  type        = set(string)
}

variable "L4_tags" {
  type        = map(string)
  description = "Map of predefined L4 tags"
}

variable "argocd_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access ArgoCD UI"
}

variable "eks_workers_subnet_cidrs" {
  type        = list(string)
  description = "List of cluster private subnets CIDRs which will be added to the ALB security groups egress rules"
}

variable "approvers_repository_access" {
  type        = map(list(string))
  description = "Teams and their repositories they can sync"
}

variable "db_credentials_secrets" {
  description = "Secrets with DB credentials. Only for proxy"
  type        = list(string)
  default     = []
}

variable "working_hours_start_cron" {
  type        = string
  description = "UTC time of the beginning of working hours"
}

variable "working_hours_end_cron" {
  type        = string
  description = "UTC time of the end of working hours"
}

variable "downscale_jumphost_after_working_hours" {
  type        = bool
  description = "Define if jumphost downscaling after working hours should be enabled"
}

variable "whitelisted_public_ingress_cidr_ranges" {
  description = "CIDR ranges to be whitelisted for public access on MSK ingress"
  type        = list(string)
  default     = []
}

variable "tm_monitoring_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access TM monitoring UI"
}

variable "tm_vault_core_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access TM monitoring UI"
}

variable "tm_monitoring_enable_ui" {
  type        = bool
  description = "Enable TM monitoring UI"
}

variable "aurora_working_hours_start_cron" {
  type        = string
  description = "UTC time of the start of aurora working hours"
}

variable "aurora_working_hours_end_cron" {
  type        = string
  description = "UTC time of the end of aurora working hours"
}

variable "prefix" {
  type        = string
  description = "Prefix"
}

variable "region_ecr" {
  description = "Region"
  type        = string
}

variable "shared_services_account_id" {
  type        = string
  description = "AWS Account ID of shared-services"
}
