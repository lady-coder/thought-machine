output "repository_clone_url_http" {
  value = aws_codecommit_repository.this.clone_url_http
}

output "repository_clone_url_ssh" {
  value = aws_codecommit_repository.this.clone_url_ssh
}

output "repository_name" {
  value = regex("arn:aws:codecommit:[a-z0-9-]+:[0-9]+:([a-zA-Z0-9-_]+)", aws_codecommit_repository.this.arn)[0]
}
