resource "aws_codecommit_repository" "this" {
  repository_name = local.name
  description     = "CodeCommit project for ${local.name}-codecommit"
}
