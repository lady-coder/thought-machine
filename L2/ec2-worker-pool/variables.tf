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

variable "configuration" {
  type        = string
  description = <<EOF
  User configuration. This allows you to decide how you want to pass your token
  to the environment - be that directly, or using SSM Parameter Store,
  Vault etc. Ultimately, here you need to export SPACELIFT_TOKEN\ to the
  environment.
  EOF
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "ami_id" {
  type        = string
  description = "ID of the Spacelift AMI (# https://github.com/spacelift-io/spacelift-worker-image/releases)"
}

variable "domain_name" {
  type        = string
  description = "Top-level domain name to use for pulling the launcher binary"
  default     = "spacelift.io"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type for the workers"
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
  description = "Minimum numbers of workers to spin up"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of workers to spin up"
  default     = 10
}

variable "desired_capacity" {
  type        = number
  description = "Desired numbers of jumphosts instances to spin up"
  default     = 1
}

variable "vpc_subnets" {
  type        = list(string)
  description = "List of VPC subnets to use"
}

variable "worker_pool_security_group_rules_egress" {
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

variable "spacelift_workers_working_hours_end_cron" {
  type        = string
  description = "spacelift workers working ends hours"
}

variable "services" {
  description = "List of AWS services that can assume the role"
  type        = list(string)
  default     = []
}
