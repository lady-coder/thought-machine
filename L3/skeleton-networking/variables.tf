variable "region" {
  description = "Region"
  type        = string
}

variable "prefix" {
  description = "Prefix"
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

variable "spacelift_ec2_ami_id" {
  description = "Spacelift worker ami id (https://github.com/spacelift-io/spacelift-worker-image/releases)"
  type        = string
  default     = ""
}

variable "spacelift_ec2_instance_type" {
  type        = string
  description = "EC2 instance type for the spacelift workers"
  default     = ""
}

variable "cidr_block" {
  type        = string
  description = "VPC cidr block"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of CIDR for private subnets inside the VPC"
  default     = []
}

variable "protected_subnets" {
  type        = list(string)
  description = "A list of CIDR for protected subnets inside the VPC"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of CIDR for public subnets inside the VPC"
}

variable "tgw_subnets" {
  type        = list(string)
  description = "A list of CIDR for tgw subnets inside the VPC"
  default     = []
}

variable "domain" {
  type        = string
  description = "Domain name"
  default     = ""
}

variable "spacelift_loggroup_retention" {
  type        = number
  description = "Spacelift worker log group retention in days. Possible values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (never expire)"
  default     = 3
}

variable "spacelift_loggroups" {
  type        = set(string)
  description = "Log groups names"
  default     = ["spacelift-errors.log", "spacelift-info.log", "amazon-cloudwatch-agent.log"]
}

variable "eip_allocation_ids" {
  type        = list(string)
  description = "Allocation IDs of Elastic IPs"
}

variable "kms_ebs_arn" {
  type        = string
  description = "CMK for EBS"
}

variable "kms_s3_arn" {
  type        = string
  description = "CMK for EBS"
}

variable "kms_cloudwatch_arn" {
  type        = string
  description = "CMK for EBS"
}

variable "xray_cmk_arn" {
  type        = string
  description = "X-Ray dedicated CMK key ARN"
  default     = ""
}

variable "kms_lambda_arn" {
  description = "ARN of Lambda KMS key"
  type        = string
}

variable "spacelift_workers_working_hours_end_cron" {
  type        = string
  description = "spacelift workers working ends hours"
  default     = ""
}

variable "create_ec2_worker_pool" {
  type        = bool
  description = "to create ec2 worker pool with condition"
}

variable "create_spacelift_worker_pool" {
  type        = bool
  description = "to create spacelift worker pool with condition"
}

variable "enabled_vpc_endpoint" {
  description = "true if you want to create ecr endpoint"
  default     = false
  type        = bool
}

variable "services" {
  description = "List of AWS services that can assume the role"
  type        = list(string)
  default     = []
}
