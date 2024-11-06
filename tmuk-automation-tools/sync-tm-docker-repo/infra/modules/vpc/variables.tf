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

variable "public_subnets" {
  type        = list(string)
  description = "A list of CIDR for public subnets inside the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of CIDR for private subnets inside the VPC"
}

variable "vpce_subnets" {
  type        = list(string)
  description = "A list of CIDR for tgw subnets inside the VPC"
}

variable "eip_allocation_id" {
  type        = string
  description = "Allocation ID of Elastic IP"
}
