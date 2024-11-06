variable "environment" {
  type        = string
  description = "Environment"
}

variable "region" {
  description = "Region"
  type        = string
}

variable "component" {
  type = string
}

variable "context" {
  type    = string
  default = ""
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "kubectl_version" {
  type        = string
  description = "Kubectl version"
  default     = "1.24.7"
}

variable "ami_id" {
  type        = string
  description = "ID of the Jumphost AMI"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type for the jumphost"
  default     = "t3.micro"
}

variable "enabled_metrics" {
  type        = list(string)
  description = "List of CloudWatch metrics enabled on the ASG"
  default = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "min_size" {
  type        = number
  description = "Minimum numbers of jumphosts instances to spin up"
  default     = 1
}

variable "desired_capacity" {
  type        = number
  description = "Desired numbers of jumphosts instances to spin up"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of jumphosts instances to spin up"
  default     = 2
}

variable "vpc_subnets" {
  type        = list(string)
  description = "List of VPC subnets to use"
}

variable "kms_s3_arn" {
  type        = string
  description = "CMK for S3"
}

variable "jumphost_security_group_rules_egress" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = {
    egress = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Egress to the world"
    }
  }
}

variable "downscale_after_working_hours" {
  default     = false
  type        = bool
  description = "Define if downscaling after working hours should be enabled"
}

variable "downscale_start_cron" {
  type        = string
  description = "UTC time of the beginning of working hours"
}

variable "downscale_end_cron" {
  type        = string
  description = "UTC time of the end of working hours"
}

variable "retention_in_days" {
  type        = number
  description = "cloudwatch log group retention"
  default     = 3
}

variable "kms_cloudwatch_arn" {
  description = "ARN of CloudWatch KMS key"
  type        = string
}

variable "kms_lambda_arn" {
  description = "ARN of Lambda KMS key"
  type        = string
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this alert lambda. 0 will disable execution. -1 is no limit"
  default     = 1
}

variable "prefix" {
  description = "Project prefix"
  type        = string
  default     = ""
}
