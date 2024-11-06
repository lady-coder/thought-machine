output "jumphost_iam_role_id" {
  value = aws_iam_role.jumphost.id
}

output "jumphost_iam_role_arn" {
  value = aws_iam_role.jumphost.arn
}

output "jumphost_iam_role_name" {
  value = aws_iam_role.jumphost.name
}

output "jumphost_security_group_id" {
  value = module.jumphost_autoscaling_group.security_group_id
}
