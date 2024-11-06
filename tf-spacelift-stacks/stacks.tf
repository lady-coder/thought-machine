module "infra_stacks" {
  count  = length(var.stacks)
  source = "./modules/blx-spacelift-stack"

  repository   = var.stacks[count.index].repository
  project_root = var.stacks[count.index].project_root

  environment = var.stacks[count.index].environment
  component   = var.stacks[count.index].component
  context     = var.stacks[count.index].context
  region      = var.stacks[count.index].region != "" ? var.stacks[count.index].region : var.region

  github_owner = var.stacks[count.index].repository == "tf-automations-github" ? var.github_org : ""

  spacelift_access_policy_id = spacelift_policy.access.id
  spacelift_push_policy_id   = spacelift_policy.push.id
  spacelift_task_policy_id   = spacelift_policy.task.id

  spacelift_runner_image         = var.spacelift_runner_image
  terraform_version              = var.stacks[count.index].terraform_version
  worker_pool_name               = var.stacks[count.index].worker_pool_name
  additional_after_init_commands = var.stacks[count.index].additional_after_init_commands
}
