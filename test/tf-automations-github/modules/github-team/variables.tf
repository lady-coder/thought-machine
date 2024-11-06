variable "description" {
  description = "(Optional) A description of the team."
  type        = string
  default     = "Team has been created by Terraform."
}

variable "team_maintainers" {
  description = "(Required) List of maintainers in the team."
  type        = set(string)
  default     = []
}

variable "team_members" {
  description = "(Required) List of members in the team."
  type        = set(string)
  default     = []
}

variable "team_name" {
  description = "(Required) The name of the team."
  type        = string
  default     = ""
}
