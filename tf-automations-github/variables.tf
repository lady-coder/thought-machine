variable "billing_email" {
  description = "The billing email address for the organization"
  type        = string
  default     = ""
}

variable "name" {
  description = "The name for the organization"
  type        = string
  default     = ""
}

variable "owner" {
  description = "This is the target GitHub organization"
  type        = string
  default     = ""
}

variable "repositories" {
  type = map(object({
    # Repository settings
    description                 = optional(string, ""),
    allow_auto_merge            = optional(string, "true"),
    allow_merge_commit          = optional(string, "false"),
    allow_squash_merge          = optional(string, "true"),
    allow_rebase_merge          = optional(string, "true"),
    allow_update_branch         = optional(string, "true"),
    alternative_default_branch  = optional(string, ""),
    archive_on_destroy          = optional(string, "true"),
    auto_init                   = optional(string, "true"),
    delete_branch_on_merge      = optional(string, "true"),
    gitignore_template          = optional(string, ""),
    has_discussions             = optional(string, "false"),
    has_issues                  = optional(string, "true"),
    has_projects                = optional(string, "false"),
    has_wiki                    = optional(string, "false"),
    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES"),
    squash_merge_commit_title   = optional(string, "PR_TITLE"),
    template_name               = optional(string, ""),
    visibility                  = optional(string, "private"),
    # Branch Protection Settings
    additional_protected_branch     = optional(set(string), []),
    dismiss_stale_reviews           = optional(string, "true"),
    required_approving_review_count = optional(number, 1),
    require_code_owner_reviews      = optional(string, "true"),
    require_conversation_resolution = optional(string, "true"),
    require_signed_commits          = optional(string, "true"),
    restrict_dismissals             = optional(string, "true"),
    # RBAC Settings
    administrators_teams = optional(set(string), []),
    maintainers_teams    = optional(set(string), []),
    contributors_teams   = optional(set(string), []),
    triage_teams         = optional(set(string), ["gft_engineers"]),
    readonly_teams       = optional(set(string), [])
  }))
  description = "Declare the name of new repo and its related attributes"
}

variable "teams" {
  description = "Declare the name of team and its members"
  type = map(object({
    description = string,
    maintainers = optional(set(string), []),
    members     = set(string)
  }))
  default = {}
}

variable "allowed_workflows_actions" {
  description = "Declare the list of allowed actions in workflows"
  type        = list(string)
  default     = []
}
