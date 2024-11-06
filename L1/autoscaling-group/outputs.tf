output "autoscaling_group_name" {
  value = aws_autoscaling_group.this.name
}

output "security_group_id" {
  value = aws_security_group.this.id
}

output "security_group_arn" {
  value = aws_security_group.this.arn
}
