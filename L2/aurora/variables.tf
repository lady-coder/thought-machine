variable "environment" {
  description = "environment"
  type        = string
}

variable "region" {
  type        = string
  description = "Region"
}

variable "component" {
  type        = string
  description = "component"
}

variable "cluster_identifier" {
  type        = string
  description = "Name of the cluster"
}

variable "vpc_id" {
  description = "VPC ID to create the cluster in"
  type        = string
}

variable "engine" {
  description = "Version of engine to be used"
  default     = "aurora-postgresql"
  type        = string
}

variable "engine_displayed_name" {
  description = "Displayed name of engine to be used"
  default     = "PostgreSQL"
  type        = string
}

variable "engine_version" {
  description = "Version of engine to be used"
  type        = string
}

variable "performance_insights_enabled" {
  description = "Version of engine to be used"
  default     = true
  type        = string
}

variable "database_name" {
  description = "Name of main database"
  default     = "postgres"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the cluster"
  type        = list(string)
  default     = []
}

variable "inbound_security_groups" {
  description = "List of security group allowed to access the cluster"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "List of VPC subnet IDs"
  type        = list(string)
}

variable "lambdas_subnets" {
  description = "List of VPC private subnet IDs"
  type        = list(string)
}

variable "instance_class" {
  description = "Instance type to use"
  type        = string
}

variable "max_conn_threshold" {
  type        = number
  description = "Threshold for max connection alarm 0.8 is equal 80%"
  default     = 0.8
}

variable "number_of_instances" {
  description = "Number of instances"
  type        = number
  default     = 2
}

variable "additional_cluster_parameters" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "List of DB cluster parameters to apply"
}

variable "aurora_cmk_arn" {
  type        = string
  description = "The ARN for the Aurora CMK's encryption key"
}

variable "ssm_parameters_cmk_arn" {
  type        = string
  description = "The ARN for the SSM Parameters CMK's encryption key"
}

variable "secretsmanager_cmk_arn" {
  type        = string
  description = "The ARN for the Secrets Manager CMK's encryption key"
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for aurora cluster"
  default     = 2
}

variable "metric_alarm_aurora_writer" {
  description = "Map of metric alarm unit for aurora writer"
  type        = map(map(string))
  default     = {}
}

variable "metric_alarm_aurora_reader" {
  description = "Map of metric alarm unit for aurora reader"
  type        = map(map(string))
  default     = {}
}

variable "preferred_maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
  default     = "postgres"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

variable "sns_topic_arn" {
  description = "The ARN for the sns topic is using for sending alert"
  type        = string
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable enhanced monitoring, specify 0, otherwise set 1, 5, 10, 15, 30 or 60"
  type        = number
  default     = 0
}

variable "enable_rds_proxy" {
  description = "Enable RDS proxy"
  type        = bool
  default     = false
}

variable "idle_client_timeout" {
  description = "Idle client timeout. Only for proxy"
  type        = number
  default     = 1800
}

variable "connection_borrow_timeout" {
  description = "Connection borrow timeout. Only for proxy"
  type        = number
  default     = 120
}

variable "db_credentials_secrets" {
  description = "Secrets with DB credentials. Only for proxy"
  type        = list(string)
  default     = []
}

variable "cloudwatch_cmk_arn" {
  type        = string
  description = "The ARN for the Cloudwatch CMK's encryption key"
}

variable "password_secret_name" {
  type        = string
  description = "Name of the secret storing the root user password"
}

variable "rds_proxy_loggroup_retention" {
  type        = number
  default     = 3
  description = "Log group retention in days. Possible values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (never expire)"
}

variable "rds_metrics_loggroup_retention" {
  type        = number
  default     = 3
  description = "Log group retention in days. Possible values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (never expire)"
}

variable "retention_in_days" {
  type        = number
  description = "cloudwatch log group retention"
  default     = 3
}

variable "kms_lambda_arn" {
  description = "ARN of Lambda KMS key"
  type        = string
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this alert lambda. 0 will disable execution. -1 is no limit"
  default     = 1
}

variable "aurora_working_hours_start_cron" {
  type        = string
  description = "aurora db working start hours"
}

variable "aurora_working_hours_end_cron" {
  type        = string
  description = "aurora db working ends hours"
}