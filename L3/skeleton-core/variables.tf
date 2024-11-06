# Skeleton global variables

variable "environment" {
  type        = string
  description = "Environment, for example sandbox or dev"
}

variable "region" {
  description = "Region"
  type        = string
}

variable "component" {
  type        = string
  default     = "apps"
  description = "Component"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the skeleton will be deployed"
}

variable "platform_cloudwatch_alert_emails" {
  description = "List of email address will received the email from SNS when metric alarm match condition"
  type        = list(string)
  default     = []
}

#MSK variables

variable "kafka_subnet_ids" {
  type        = list(string)
  description = "IDs of the subnets where MSK will be deployed"
}

variable "kafka_client_authentication" {
  type = object({
    iam   = bool
    scram = bool
  })
  description = "Kafka client authentication: SCRAM, IAM"
  default = {
    iam   = false
    scram = false
  }
}

variable "kafka_number_of_brokers" {
  type        = number
  description = "Number of brokers attached to Kafka cluster"
  default     = 3
}

variable "kafka_broker_instance_type" {
  type        = string
  description = "Kafka broker instance type"
  default     = "kafka.t3.small"
}

variable "kafka_broker_volume_size" {
  type        = number
  description = "Kafka broker volume size in GiB"
  default     = 10
}

variable "kafka_broker_loggroup_retention" {
  type        = number
  default     = 3
  description = "Log group retention in days. Possible values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (never expire)"
}

variable "kafka_connector_loggroup_retention" {
  type        = number
  default     = 3
  description = "Log group retention in days. Possible values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (never expire)"
}

variable "apps_jumphost_security_group_id" {
  type        = string
  description = "ID of security group assigned to Apps jumphost ASG"
}

variable "msk_platform_secrets" {
  type        = set(string)
  description = "Names of MSK dedicated secrets to be created within Core skeleton"
}

# Aurora variables
variable "aurora_working_hours_start_cron" {
  type        = string
  description = "aurora db working start hours"
}

variable "aurora_working_hours_end_cron" {
  type        = string
  description = "aurora db working ends hours"
}

variable "lambdas_subnet_ids" {
  type        = list(string)
  description = "List of private subnets IDs for lambdas"
}

variable "kms_lambda_arn" {
  description = "ARN of Lambda KMS key"
  type        = string
}

variable "aurora_subnet_ids" {
  type        = list(string)
  description = "IDs of the subnets where Aurora will be deployed"
}

variable "aurora_instance_class" {
  type        = string
  description = "Aurora instance class"
}

variable "aurora_number_of_instances" {
  description = "Aurora number of instances"
  type        = number
  default     = 2
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for aurora cluster"
  default     = 2
}

variable "preferred_maintenance_window" {
  description = "The window to perform maintenance"
  type        = string
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable enhanced monitoring, specify 0, otherwise set 1, 5, 10, 15, 30 or 60"
  type        = number
  default     = 0
}

# kms CMK's ARNs

variable "msk_cmk_arn" {
  type        = string
  description = "The ARN for the MSK CMK's encryption key"
}

variable "aurora_cmk_arn" {
  type        = string
  description = "The ARN for the Aurora CMK's encryption key"
}

variable "ssm_cmk_arn" {
  type        = string
  description = "The ARN for the SSM CMK's encryption key"
}

variable "secretsmanager_cmk_arn" {
  type        = string
  description = "The ARN for the Secrets Manager CMK's encryption key"
}

variable "sns_cmk_arn" {
  type        = string
  description = "The ARN for the SNS CMK's encryption key"
}

variable "cloudwatch_cmk_arn" {
  type        = string
  description = "The ARN for the Cloudwatch CMK's encryption key"
}

# parameters from Kubernetes skeleton

variable "iam_openid_connect_provider_url" {
  type        = string
  description = "URL of OIDC provider for target cluster"
}

variable "iam_openid_connect_provider_arn" {
  type        = string
  description = "ARN of OIDC provider for target cluster"
}

variable "apps_control_plane_security_group_id" {
  type        = string
  description = "ID of cluster security group created by EKS during the Apps cluster creation (the one not managed via Terraform)"
}

variable "apps_cluster_worker_node_role_name" {
  type        = string
  description = "ARN of Apps cluster worker node IAM role to be extended with additional privileges"
}

variable "apps_jumphost_role_name" {
  type        = string
  description = "ARN of Apps jumphost IAM role to be extended with additional privileges"
}

variable "sns_metric_alert_topic_arn" {
  type        = string
  description = "ARN of SNS topic dedicated for metric alerts"
}

variable "enable_rds_proxy" {
  description = "Enable RDS proxy"
  type        = bool
  default     = false
}

variable "db_credentials_secrets" {
  description = "Secrets with DB credentials. Only for proxy"
  type        = list(string)
  default     = []
}

variable "enable_broker_logs_export" {
  description = "Enable export of MSK broker logs to Cloudwatch log group"
  type        = bool
  default     = true
}

variable "deploy_msk_in_public" {
  type        = bool
  description = "Deploy msk in public access if set true"
  default     = false
}

variable "enable_msk_configuration_public_access" {
  type        = bool
  description = "Enable msk configuration for public access"
  default     = false
}

variable "whitelisted_public_ingress_cidr_ranges" {
  description = "CIDR ranges to be whitelisted for public access on MSK ingress"
  type        = list(string)
  default     = []
}

variable "enable_msk_configuration_for_tm" {
  type        = bool
  description = "Enable msk configuration for TM installation"
  default     = false
}
