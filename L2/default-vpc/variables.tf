variable "region" {
  description = "Region"
  type        = string
}

variable "component" {
  type        = string
  description = "component"
}

variable "prefix" {
  type        = string
  description = "prefix"
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

variable "private_subnets" {
  type        = list(string)
  description = "A list of CIDR for private subnets inside the VPC"
}

variable "protected_subnets" {
  type        = list(string)
  description = "A list of CIDR for protected subnets inside the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of CIDR for public subnets inside the VPC"
}

variable "tgw_subnets" {
  type        = list(string)
  description = "A list of CIDR for tgw subnets inside the VPC"
}

variable "eip_allocation_ids" {
  type        = list(string)
  description = "Allocation IDs of Elastic IPs"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Should be true if you want to provision NAT Gateways. If it's false then we use transit gateway for private subnets routing"
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = true
}

variable "one_nat_gateway_per_az" {
  type        = bool
  description = "true if you want only one NAT Gateway per availability zone"
  default     = false
}

variable "domain" {
  type        = string
  description = "Domain name"
  default     = ""
}

variable "max_aggregation_interval" {
  type        = number
  description = "The maximum interval of time during which a flow of packets is captured"
  default     = 600
}

variable "kms_s3" {
  type        = string
  description = "The ARN for the S3 flow logs bucket encryption key"
}

variable "enabled_vpc_endpoint" {
  type        = bool
  description = "true if you want to create ecr endpoint"
  default     = false
}
