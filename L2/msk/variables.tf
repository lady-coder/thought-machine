variable "environment" {
  type        = string
  description = "Environment, for example sandbox or dev"
}

variable "component" {
  type        = string
  description = "Component, for example ci or apps"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC in which the security group will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs that MSK brokers reside in"
}

variable "inbound_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be allowed to connect to the cluster"
}

variable "cluster_name" {
  type = string
}

variable "kafka_version" {
  type        = string
  description = "Specify the desired Kafka software version"
}

variable "broker_instance_type" {
  type        = string
  description = "Specify the instance type to use for the kafka brokers"
}

variable "broker_volume_size" {
  type        = number
  default     = 50
  description = "The size in GiB of the EBS volume for the data drive on each broker node"
}

variable "number_of_broker_nodes" {
  type        = number
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
}

variable "whitelisted_private_ingress_cidr_ranges" {
  type        = list(string)
  default     = []
  description = "CIDR ranges to be whitelisted for private access on MSK ingress"
}

variable "whitelisted_public_ingress_cidr_ranges" {
  description = "CIDR ranges to be whitelisted for public access on MSK ingress"
  type        = list(string)
  default     = []
}

variable "client_authentication" {
  description = "Supports: IAM/SCRAM"
  type = object({
    iam   = bool
    scram = bool
  })
  default = {
    iam   = true
    scram = true
  }
}

variable "msk_cmk_arn" {
  type        = string
  description = "ARN of MSK dedicated KMS"
}

variable "cloudwatch_cmk_arn" {
  type        = string
  description = "The ARN for the Cloudwatch CMK's encryption key"
}

variable "alarm_msk_broker" {
  description = "List of metric alarm unit for msk broker"
  type        = list(map(string))
  default     = []
}

variable "alarm_msk_cluster" {
  description = "List of metric alarm unit for msk cluster"
  type        = list(map(string))
  default     = []
}

variable "sns_topic_arn" {
  description = "The ARN for the sns topic is using for sending alert"
  type        = string
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

variable "log_group_prefix" {
  description = "Prefix for the related Cloudwatch log groups"
  type        = string
  default     = "/aws/msk"
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

variable "enable_msk_configuration_for_tm" {
  type        = bool
  description = "Enable msk configuration for TM installation"
  default     = false
}
