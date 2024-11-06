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

variable "domain" {
  type        = string
  description = "Domain name"
  default     = ""
}

variable "subdomain" {
  type        = string
  description = "Subdomain name"
  default     = ""
}

variable "spacelift_ec2_ami_id" {
  type        = string
  description = "Spacelift worker ami id (https://github.com/spacelift-io/spacelift-worker-image/releases)"
}

variable "spacelift_ec2_instance_type" {
  type        = string
  description = "EC2 instance type for the spacelift workers"
}

variable "L4_tags" {
  type        = map(string)
  description = "Map of predefined L4 tags"
}

variable "elastic_ip_identifiers" {
  type        = list(string)
  description = "List of eip identifiers"
}
