# Global Variables
variable "environment" {
  description = "Environment"
  type        = string

  default = ""
}

variable "region" {
  description = "Region"
  type        = string

  default = ""
}

# Spacelift Global Policies
variable "spacelift_access_policy_id" {
  description = "ID of global access policy"
  type        = string

  default = ""
}

variable "spacelift_push_policy_id" {
  description = "ID of global push policy"
  type        = string

  default = ""
}

variable "spacelift_task_policy_id" {
  description = "ID of global task policy"
  type        = string

  default = ""
}

# Stack Variables
variable "additional_after_init_commands" {
  description = "Indicates whether this stack can manage others"
  type        = list(string)

  default = []
}

variable "administrative" {
  description = "Indicates whether this stack can manage others"
  type        = bool

  default = false
}

variable "autodeploy" {
  description = "Indicates whether changes to this stack can be automatically deployed"
  type        = bool

  default = false
}

variable "branch" {
  description = "GitHub branch to apply changes to"
  type        = string

  default = "main"
}

variable "component" {
  description = "Component, for example Apps or CI"
  type        = string

  default = ""
}

variable "context" {
  type        = string
  description = "Context, for example Networking, Infra, Observability or Data"

  default = ""
}

variable "enable_local_preview" {
  description = "Indicates whether local preview runs can be triggered on this Stack"
  type        = bool

  default = true
}

variable "manage_state" {
  description = "Determines if Spacelift should manage state for this stack"
  type        = bool

  default = false
}

variable "terraform_smart_sanitization" {
  description = "Ssanitize the outputs of Terraform state and plans in spacelift instead of sanitizing all fields"
  type        = bool

  default = true
}

variable "project_root" {
  description = "Optional directory relative to the workspace root containing the entrypoint to the Stack"
  type        = string

  default = ""
}

variable "repository" {
  description = "L4 repository"
  type        = string

  default = ""
}

variable "spacelift_runner_image" {
  description = "Docker image that Spacelift worker pool uses to run CI and CD steps on"
  type        = string

  default = ""
}

variable "terraform_version" {
  description = "Terraform version used across Spacelift stacks"
  type        = string

  default = ""
}

variable "worker_pool_name" {
  description = "Name of the worker pool to be used for stack. It have to already exist on a Spacelift"
  type        = string

  default = ""
}

# Stack Environment Variables
variable "github_owner" {
  description = "Github owner name"
  type        = string

  default = ""
}
