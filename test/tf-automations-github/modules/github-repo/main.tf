resource "github_repository" "this" {
  #checkov:skip=CKV_GIT_1: "Ensure GitHub repository is Private"
  #checkov:skip=CKV_GIT_3: "Ensure GitHub repository has vulnerability alerts enabled"
  name        = var.repo_name
  description = var.description
  is_template = contains(var.template_repositories, var.repo_name)

  allow_auto_merge            = var.allow_auto_merge
  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  allow_update_branch         = var.allow_update_branch
  auto_init                   = var.auto_init
  archive_on_destroy          = var.archive_on_destroy
  delete_branch_on_merge      = var.delete_branch_on_merge
  gitignore_template          = var.gitignore_template
  has_discussions             = var.has_discussions
  has_issues                  = var.has_issues
  has_projects                = var.has_projects
  has_wiki                    = var.has_wiki
  squash_merge_commit_message = var.squash_merge_commit_message
  squash_merge_commit_title   = var.squash_merge_commit_title
  visibility                  = var.visibility

  dynamic "template" {
    for_each = var.template_name == "" ? [] : [1]
    content {
      owner      = var.owner
      repository = var.template_name
    }
  }
}

resource "github_branch" "feature_branch" {
  count      = var.alternative_default_branch != "" ? 1 : 0
  repository = var.repo_name
  branch     = var.alternative_default_branch

  depends_on = [
    github_repository.this
  ]
}

resource "github_branch_default" "feature_branch" {
  count      = var.alternative_default_branch != "" ? 1 : 0
  repository = var.repo_name
  branch     = var.alternative_default_branch
  rename     = true

  depends_on = [
    github_branch.feature_branch
  ]
}

resource "github_branch_protection" "this" {
  #checkov:skip=CKV_GIT_5: "GitHub pull requests should require at least 2 approvals"
  #checkov:skip=CKV_GIT_6: "Ensure GitHub branch protection rules requires signed commits"
  count         = var.alternative_default_branch != "" ? 0 : 1
  repository_id = var.repo_name
  pattern       = "main"

  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = var.require_conversation_resolution
  require_signed_commits          = var.require_signed_commits

  required_status_checks {
    strict = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = var.dismiss_stale_reviews
    restrict_dismissals             = var.restrict_dismissals
    require_code_owner_reviews      = var.require_code_owner_reviews
    required_approving_review_count = var.required_approving_review_count
  }

  depends_on = [
    github_repository.this
  ]
}

resource "github_branch_protection" "feature_branch" {
  #checkov:skip=CKV_GIT_5: "GitHub pull requests should require at least 2 approvals"
  #checkov:skip=CKV_GIT_6: "Ensure GitHub branch protection rules requires signed commits"
  for_each      = toset(local.alternative_protected_branch)
  repository_id = var.repo_name
  pattern       = each.value

  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = var.require_conversation_resolution
  require_signed_commits          = var.require_signed_commits

  required_status_checks {
    strict = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = var.dismiss_stale_reviews
    restrict_dismissals             = var.restrict_dismissals
    require_code_owner_reviews      = var.require_code_owner_reviews
    required_approving_review_count = var.required_approving_review_count
  }

  depends_on = [
    github_repository.this
  ]
}

resource "github_team_repository" "admin_access" {
  for_each = var.administrators_teams

  team_id    = lookup(element(var.github_name_id_mappings, index(var.github_name_id_mappings[*].name, each.key)), "id")
  repository = var.repo_name
  permission = "admin"

  depends_on = [
    github_repository.this
  ]
}

resource "github_team_repository" "maintain_access" {
  for_each = var.maintainers_teams

  team_id    = lookup(element(var.github_name_id_mappings, index(var.github_name_id_mappings[*].name, each.key)), "id")
  repository = var.repo_name
  permission = "maintain"

  depends_on = [
    github_repository.this
  ]
}

resource "github_team_repository" "write_access" {
  for_each = var.contributors_teams

  team_id    = lookup(element(var.github_name_id_mappings, index(var.github_name_id_mappings[*].name, each.key)), "id")
  repository = var.repo_name
  permission = "push"

  depends_on = [
    github_repository.this
  ]
}

resource "github_team_repository" "triage_access" {
  for_each = var.triage_teams

  team_id    = lookup(element(var.github_name_id_mappings, index(var.github_name_id_mappings[*].name, each.key)), "id")
  repository = var.repo_name
  permission = "triage"

  depends_on = [
    github_repository.this
  ]
}


resource "github_team_repository" "readonly_access" {
  for_each = var.readonly_teams

  team_id    = lookup(element(var.github_name_id_mappings, index(var.github_name_id_mappings[*].name, each.key)), "id")
  repository = var.repo_name
  permission = "pull"

  depends_on = [
    github_repository.this
  ]
}
