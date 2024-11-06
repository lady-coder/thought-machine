variable "environment" {
  type        = string
  description = "Environment"
}

variable "component" {
  type        = string
  description = "Component"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "prefix" {
  type        = string
  description = "prefix"
}

variable "context" {
  type        = string
  description = "Context"
}

variable "ip_rate_based_limit_per_5min" {
  type        = number
  default     = 20000
  description = "Number of limit to IP in span 5 minutes"
}

variable "max_payload_size_in_bytes" {
  type        = number
  default     = 8192
  description = "A size_constraint rule tracks the size of requests for each originating IP address, and triggers the rule action when the size exceeds"
}

variable "managed_rules_common_rules_excluded" {
  type        = list(string)
  description = "list of managed_rules_commonrule_excluded"
  default     = []
}

variable "managed_rules_linux_rules_excluded" {
  type        = list(string)
  description = "list of managed_rules_linux_rule_excluded"
  default     = []
}

variable "enable_logging" {
  type        = bool
  description = "Enable/Disable log storage for WAF"
  default     = true
}

variable "blocked_countries" {
  type        = list(string)
  description = "All the request from these countries will be blocked by WAF"
  default     = []
}

variable "kms_s3_arn" {
  type        = string
  description = "CMK for S3"
}

variable "require_api_key" {
  type        = bool
  description = "Enable/Disable block_x_api_key rule"
}

variable "api_key" {
  type        = string
  sensitive   = true
  description = "api_key to access graphql"
  default     = ""
}

variable "allowed_paths" {
  type        = list(string)
  description = "list of allowed paths"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC containing the EKS cluster for whick the ALBs will be created"
}

variable "domain_names" {
  type        = list(string)
  description = "list of domains names"
}

variable "public_zone_id" {
  type        = string
  description = "Public Route53 zone id"
}

variable "allowed_source_ips" {
  type = set(object({
    cidr_blocks = set(string)
    description = string
  }))
  description = "list of source IPs allowed by Security Group"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of opened ingress ports"
  default     = [443]
}

variable "eks_workers_subnets_cidr_blocks" {
  type        = list(string)
  description = "list of target private subnets CIDRs for ALB egress Security Group rules"
}
