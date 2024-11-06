
module "github_team" {
  source = "./modules/github-team/"

  for_each = var.teams

  team_name        = each.key
  description      = each.value.description
  team_maintainers = each.value.maintainers
  team_members     = each.value.members
}

module "github_repo" {
  source = "./modules/github-repo/"

  for_each = var.repositories

  owner         = var.owner
  repo_name     = each.key
  description   = each.value.description
  template_name = each.value.template_name

  allow_merge_commit          = each.value.allow_merge_commit
  allow_squash_merge          = each.value.allow_squash_merge
  allow_rebase_merge          = each.value.allow_rebase_merge
  allow_update_branch         = each.value.allow_update_branch
  auto_init                   = each.value.auto_init
  alternative_default_branch  = each.value.alternative_default_branch
  archive_on_destroy          = each.value.archive_on_destroy
  delete_branch_on_merge      = each.value.delete_branch_on_merge
  gitignore_template          = each.value.gitignore_template
  has_discussions             = each.value.has_discussions
  has_issues                  = each.value.has_issues
  has_projects                = each.value.has_projects
  has_wiki                    = each.value.has_wiki
  squash_merge_commit_message = each.value.squash_merge_commit_message
  squash_merge_commit_title   = each.value.squash_merge_commit_title
  visibility                  = each.value.visibility

  # Branch Protection Settings
  additional_protected_branch     = each.value.additional_protected_branch
  dismiss_stale_reviews           = each.value.dismiss_stale_reviews
  required_approving_review_count = each.value.required_approving_review_count
  require_code_owner_reviews      = each.value.require_code_owner_reviews
  require_conversation_resolution = each.value.require_conversation_resolution
  require_signed_commits          = each.value.require_signed_commits
  restrict_dismissals             = each.value.restrict_dismissals

  # RBAC Settings
  administrators_teams = each.value.administrators_teams
  maintainers_teams    = each.value.maintainers_teams
  contributors_teams   = each.value.contributors_teams
  triage_teams         = each.value.triage_teams
  readonly_teams       = each.value.readonly_teams

  github_name_id_mappings = values(module.github_team)[*].github_name_id_mapping
  template_repositories   = values(var.repositories)[*].template_name
}

resource "github_organization_settings" "this" {
  billing_email                            = var.billing_email
  name                                     = var.name
  has_organization_projects                = false
  members_can_create_repositories          = false
  members_can_create_public_repositories   = false
  members_can_create_private_repositories  = false
  members_can_create_internal_repositories = false
  members_can_create_pages                 = false
  members_can_create_public_pages          = false
  members_can_create_private_pages         = false
  members_can_fork_private_repositories    = false
}

resource "github_actions_organization_permissions" "this" {

  allowed_actions = "selected"
  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = true
    patterns_allowed     = var.allowed_workflows_actions
  }

  enabled_repositories = "selected"
  enabled_repositories_config {
    repository_ids = values(module.github_repo)[*].github_repository_id
  }
}

resource "github_actions_runner_group" "ci_apps_runner_group" {
  name                    = "shared-services-apps"
  visibility              = "selected"
  selected_repository_ids = values(module.github_repo)[*].github_repository_id
}

resource "github_actions_runner_group" "ci_platform_runner_group" {
  name                    = "shared-services-platform"
  visibility              = "selected"
  selected_repository_ids = values(module.github_repo)[*].github_repository_id
}
