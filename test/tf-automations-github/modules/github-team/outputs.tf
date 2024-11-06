output "github_team_id" {
  value = github_team.this.id
}

output "github_team_slug" {
  value = github_team.this.slug
}

output "github_name_id_mapping" {
  value = {
    name = github_team.this.name
    id   = github_team.this.id
  }
}
