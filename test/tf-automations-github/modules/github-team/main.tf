resource "github_team" "this" {
  name                      = var.team_name
  description               = var.description
  privacy                   = "closed"
  create_default_maintainer = true
}

resource "github_team_membership" "maintainers" {
  for_each = var.team_maintainers

  team_id  = github_team.this.id
  username = each.value
  role     = "maintainer"

  depends_on = [
    github_team.this
  ]
}

resource "github_team_membership" "members" {
  for_each = var.team_members

  team_id  = github_team.this.id
  username = each.value
  role     = "member"

  depends_on = [
    github_team.this
  ]
}
