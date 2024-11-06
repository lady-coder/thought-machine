variable "region" {
  description = "Region"
  type        = string

  default = ""
}

variable "github_org" {
  description = "Name of github organization"
  type        = string

  default = ""
}

variable "stacks" {
  description = "List containing the parameters of a stacks to be created"
  type = list(object({
    repository                     = string
    environment                    = string
    component                      = string
    context                        = string
    worker_pool_name               = string
    region                         = string
    terraform_version              = string
    project_root                   = string
    additional_after_init_commands = list(string)
  }))

  default = []
}

variable "spacelift_runner_image" {
  description = "Docker image that Spacelift worker pool uses to run CI and CD steps on"
  type        = string

  default = ""
}
