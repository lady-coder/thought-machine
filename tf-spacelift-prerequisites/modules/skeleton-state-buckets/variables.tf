variable "region" {
  type        = string
  description = "Region in which the resources will be deployed"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "L4_tags" {
  type        = map(string)
  description = "Map of injected L4 tags"
}

variable "L3_tags" {
  type = map(string)
  default = {
    "blx:skeleton-name" = "skeleton-state-buckets"
  }
}
