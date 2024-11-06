variable "environment" {
  type        = string
  description = "environment"
}

variable "component" {
  type        = string
  description = "Component"
}

variable "region" {
  type        = string
  description = "Region in which the resources will be deployed"
}

variable "L4_tags" {
  type        = map(string)
  description = "Map of predefined L4 tags"
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

variable "cidr_block" {
  type        = string
  description = "VPC cidr block"
}

variable "ami_id" {
  type        = string
  description = "ID of the operations server AMI"
}

variable "pipeline_stages" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = list(map(any))
}
