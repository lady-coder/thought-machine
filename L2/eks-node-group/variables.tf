variable "environment" {
  type = string
}

variable "prefix" {
  type        = string
  description = "Prefix"
}

variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.23"
}

variable "node_groups" {
  type = map(object({
    disk_size                     = number
    instance_types                = list(string)
    capacity_type                 = string
    subnet_ids                    = list(string)
    desired_capacity              = number
    max_size                      = number
    min_size                      = number
    downscale_after_working_hours = bool
    downscale_schedule_cron       = string
    upscale_schedule_cron         = string
    kubernetes_taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = {
    on_demand = {
      disk_size                     = 50
      instance_types                = ["t3.micro"]
      capacity_type                 = "ON_DEMAND"
      subnet_ids                    = []
      desired_capacity              = 1
      max_size                      = 10
      min_size                      = 1
      downscale_after_working_hours = false
      downscale_schedule_cron       = ""
      upscale_schedule_cron         = ""
      kubernetes_taints             = []
    }
  }
}

variable "ami_type" {
  default = "AL2_x86_64"
  type    = string
}

variable "eks_cluster_sg" {
  type        = string
  description = "Security group attach to node group"
}

variable "eks_cluster_ca" {
  type        = string
  description = "Base64 encode of eks certificate authority"
}

variable "eks_cluster_api" {
  type        = string
  description = "The API URL of eks cluster"
}

variable "eks_iam_node_group_role_name" {
  type        = string
  description = "Name of IAM role to be created and used by all the node groups assigned to the EKS cluster "
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = map(object({
    device_name = string
    ebs = object({
      delete_on_termination = bool
      volume_size           = number
      volume_type           = string
    })
  }))
  default = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        delete_on_termination = true
        volume_size           = 50
        volume_type           = "gp3"
      }
    }
  }
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "metrics_collection_interval" {
  description = "How often all metrics specified in user_data file are to be collected"
  type        = number
  default     = 120
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this alert lambda. 0 will disable execution. -1 is no limit"
  default     = 1
}

variable "aws_auth_configmap_name" {
  type        = string
  description = "Unused. Express dependency"
}
