variable "environment" {
  type        = string
  description = "Environment"
}

variable "component" {
  type        = string
  description = "component"
}

variable "context" {
  type        = string
  default     = ""
  description = "context"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "image_id" {
  type        = string
  description = "ID of the Instance AMI"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the asg"
}

variable "desired_capacity" {
  type        = number
  description = "Desired numbers of instances to spin up"
}

variable "max_size" {
  type        = number
  description = "Maximum numbers of instances to spin up"
}

variable "min_size" {
  type        = number
  description = "Minimum numbers of instances to spin up"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of VPC subnets to use"
}

variable "user_data" {
  default     = null
  type        = string
  description = "User configuration of the instances"
}

variable "aws_iam_instance_profile_name" {
  type        = string
  default     = null
  description = "Instance profile of the instances, IAM role for example can be attached to ASG's instances"
}

variable "security_group_rules_egress" {
  default = {}
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  description = "Egress security group for the ASG's instances"
}

variable "enable_asg_policy" {
  default     = false
  type        = bool
  description = "Define if ASG policy should be used for the ASG's instances"
}

variable "asg_policy_target_value" {
  type        = number
  default     = 80.0
  description = "If ASG policy is enable, define % of target for target scaling"
}

variable "asg_disable_scale_in" {
  default     = false
  type        = bool
  description = "Define if scale in should be enabled"
}

variable "lifecycle_hook_timeout" {
  type        = number
  default     = 7200
  description = "Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out"
}

variable "enabled_metrics" {
  type        = list(string)
  description = "List of CloudWatch metrics enabled on the ASG"
  default     = null
}

variable "health_check_grace_period" {
  type        = number
  default     = 30
  description = "Time (in seconds) after instance comes into service before checking health."
}

variable "default_cooldown" {
  type        = number
  default     = 10
  description = "Amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
}

variable "wait_for_capacity_timeout" {
  type        = number
  default     = 0
  description = "Maximum duration that Terraform should wait for ASG instances to be healthy before timing out."
}

variable "health_check_type" {
  default     = "EC2"
  type        = string
  description = "'EC2' or 'ELB'. Controls how health checking is done"
}

variable "on_demand_base_capacity" {
  type        = number
  default     = 0
  description = "Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances"
}

variable "on_demand_percentage_above_base_capacity" {
  type        = number
  default     = 100
  description = "Percentage split between on-demand and Spot instances above the base on-demand capacity"
}

variable "spot_allocation_strategy" {
  type        = string
  default     = "lowest-price"
  description = "How to allocate capacity across the Spot pools"
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

variable "prefix" {
  description = "Project prefix"
  type        = string
  default     = ""
}
