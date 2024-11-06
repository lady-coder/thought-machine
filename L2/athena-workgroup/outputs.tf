output "workgroup_id" {
  description = "ID of newly created Athena workgroup."
  value       = try(aws_athena_workgroup.default, null)
}