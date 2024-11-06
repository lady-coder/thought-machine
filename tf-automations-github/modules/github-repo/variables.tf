# Repository Settings
variable "description" {
  description = "(Optional) A description of the repository."
  type        = string
  default     = ""
}

variable "github_name_id_mappings" {
  description = "List of Github teams Name->ID mappings"
  type        = list(map(string))
  default     = []
}

variable "owner" {
  description = "(Required) This is the target GitHub organization"
  type        = string
  default     = ""
}

variable "repo_name" {
  description = "(Required) The name of the repository."
  type        = string
  default     = ""
}

variable "template_name" {
  description = "(Optional) The name of the template repository."
  type        = string
  default     = ""
}

variable "template_repositories" {
  description = "List of repositories that are templates"
  type        = list(string)
  default     = []
}

# Repository general configurations
variable "allow_auto_merge" {
  description = "(Optional) Allow allow auto-merging pull requests on the repository."
  type        = string
  default     = "false"
}

variable "allow_merge_commit" {
  description = "(Optional) Allow merge commits on the repository."
  type        = string
  default     = "false"
}

variable "allow_squash_merge" {
  description = "(Optional) Allow squash merges on the repository."
  type        = string
  default     = "false"
}

variable "allow_rebase_merge" {
  description = "(Optional) Allow rebase merges on the repository."
  type        = string
  default     = "false"
}

variable "allow_update_branch" {
  description = "(Optional) always suggest updating pull request branches."
  type        = string
  default     = "false"
}

variable "alternative_default_branch" {
  description = "(Optional) An alternative default branch of the repository."
  type        = string
  default     = ""
}

variable "additional_protected_branch" {
  description = "(Optional) Additional protected branches of the repository."
  type        = set(string)
  default     = []
}

variable "archive_on_destroy" {
  description = "(Optional) Archive the repository instead of deleting on destroy."
  type        = string
  default     = "false"
}

variable "auto_init" {
  description = "(Optional) Produce an initial commit in the repository."
  type        = string
  default     = "false"
}

variable "delete_branch_on_merge" {
  description = "(Optional) Automatically delete head branch after a pull request is merged."
  type        = string
  default     = "false"
}

variable "gitignore_template" {
  description = "(Optional) Use the name of the template without the extension."
  type        = string
  default     = ""
}

variable "has_discussions" {
  description = "(Optional) Whether enabling the Github Discussions features on the repository."
  type        = string
  default     = "false"
}

variable "has_issues" {
  description = "(Optional) Whether enabling the Github Issues features on the repository."
  type        = string
  default     = "false"
}

variable "has_projects" {
  description = "(Optional) Whether enabling the Github Projects features on the repository."
  type        = string
  default     = "false"
}

variable "has_wiki" {
  description = "(Optional) Whether enabling the Github Projects features on the repository."
  type        = string
  default     = "false"
}

variable "squash_merge_commit_message" {
  description = "(Optional) A default squash merge commit message."
  type        = string
  default     = "COMMIT_MESSAGES"
}

variable "squash_merge_commit_title" {
  description = "(Optional) A default squash merge commit title."
  type        = string
  default     = "PR_TITLE"
}

variable "visibility" {
  description = "(Optional) The visibility of the repository."
  type        = string
  default     = "internal"
}

# Branch Protection Rules
variable "dismiss_stale_reviews" {
  description = "(Optional) Dismiss approved reviews automatically when a new commit is pushed."
  type        = string
  default     = "false"
}

variable "required_approving_review_count" {
  description = "(Optional) Require x number of approvals to satisfy branch protection requirements (0-6)."
  type        = number
  default     = 0
}

variable "require_code_owner_reviews" {
  description = "(Optional) Require an approved review in pull requests including files with a designated code owner."
  type        = string
  default     = "false"
}

variable "require_conversation_resolution" {
  description = "(Optional) Requires all conversations on code must be resolved before a pull request can be merged."
  type        = string
  default     = "false"
}

variable "require_signed_commits" {
  description = "(Optional) Requires all commits to be signed with GPG."
  type        = string
  default     = "false"
}

variable "restrict_dismissals" {
  description = "(Optional) Restrict pull request review dismissals."
  type        = string
  default     = "false"
}

# RBAC Settings
variable "administrators_teams" {
  description = "(Optional) List of teams with the administrator access to the repository"
  type        = set(string)
  default     = []
}

variable "maintainers_teams" {
  description = "(Optional) List of teams with the maintainer access to the repository"
  type        = set(string)
  default     = []
}

variable "contributors_teams" {
  description = "(Optional) List of teams with the write access to the repository"
  type        = set(string)
  default     = []
}

variable "triage_teams" {
  description = "(Optional) List of teams with the triage access to the repository"
  type        = set(string)
  default     = []
}

variable "readonly_teams" {
  description = "(Optional) List of teams with the read-only access to the repository"
  type        = set(string)
  default     = []
}
