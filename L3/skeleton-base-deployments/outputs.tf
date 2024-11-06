output "role_names_map" {
  value = concat(
    values(module.platform_base_irsa_roles)[*].irsa_application_name_to_role_name_mapping,
    values(module.platform_env_dedicated_irsa_roles)[*].irsa_application_name_to_role_name_mapping
  )
}

output "role_arns_map" {
  value = concat(
    values(module.platform_base_irsa_roles)[*].irsa_application_name_to_arn_mapping,
    values(module.platform_env_dedicated_irsa_roles)[*].irsa_application_name_to_arn_mapping
  )
}

output "eks_node_group_iam_role_arn" {
  value = module.eks_node_group.iam_role_arn
}

output "eks_node_group_iam_role_name" {
  value = module.eks_node_group.iam_role_name
}
