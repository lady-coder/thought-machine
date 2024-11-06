variable "region" {
  description = "Region"
  type        = string
}

variable "component" {
  type        = string
  description = "component"
}

variable "context" {
  type        = string
  description = "context"
  default     = ""
}

variable "environment" {
  type        = string
  description = "environment"
}

variable "cidr_block" {
  type        = string
  description = "VPC cidr block"
}

variable "extra_cidr_blocks" {
  type        = list(string)
  description = "Additional IPv4 CIDR ranges to associate to VPC"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of CIDR for public subnets inside the VPC"
  default     = []
}

variable "private_api_subnets" {
  type        = list(string)
  description = "A list of CIDR for protected subnets inside the VPC"
  default     = []
}

variable "msk_subnets" {
  type        = list(string)
  description = "A list of CIDR for protected subnets inside the VPC"
  default     = []
}

variable "db_subnets" {
  type        = list(string)
  description = "A list of CIDR for protected subnets inside the VPC"
  default     = []
}

variable "endpoints_subnets" {
  type        = list(string)
  description = "A list of CIDR for protected subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of CIDR for private subnets inside the VPC"
  default     = []
}

variable "eip_allocation_ids" {
  type        = list(string)
  description = "Allocation IDs of Elastic IPs"
}

variable "number_of_nats" {
  type        = number
  description = "Number of NAT gateway"
  default     = 1
}

variable "domain" {
  type        = string
  description = "Domain name"
  default     = ""
}

variable "subdomain" {
  type        = string
  description = "Subdomain name"
  default     = "api"
}

variable "max_aggregation_interval" {
  type        = number
  description = "The maximum interval of time during which a flow of packets is captured"
  default     = 600
}

variable "kms_s3" {
  type        = string
  description = "The ARN for the S3 flow logs bucket encryption key"
  default     = ""
}
