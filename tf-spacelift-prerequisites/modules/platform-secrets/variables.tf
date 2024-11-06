variable "region" {
  type        = string
  description = "Region in which the resources will be deployed"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "component" {
  type        = string
  description = "Component"
}

variable "create_appmesh_certificate_secrets" {
  type        = bool
  description = "if true, this module will create secrets which will contain certifcate secrets used by AppMesh to establish encryption in transit between services. Not required for shared service environment"
  default     = false
}

variable "create_apollo_api_key_secret" {
  type        = bool
  description = "if true, this module will create secret used by Apollo's WAF. Not required for shared service environment"
  default     = false
}

variable "create_microservices_api_key_secret" {
  type        = bool
  description = "Create a secret for an api-key for microservices WAF. Not required for shared service environment"
  default     = false
}

variable "L4_tags" {
  type        = map(string)
  description = "Map of injected L4 tags"
}

variable "L3_tags" {
  type = map(string)
  default = {
    "blx:skeleton-name" = "platform-secrets"
  }
}
