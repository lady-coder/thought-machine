
resource "spacelift_stack" "this" {
  name        = local.name
  description = local.description

  administrative               = var.administrative
  after_init                   = local.after_init_commands
  autodeploy                   = var.autodeploy
  branch                       = var.branch
  enable_local_preview         = var.enable_local_preview
  manage_state                 = var.manage_state
  project_root                 = var.project_root
  repository                   = var.repository
  runner_image                 = var.spacelift_runner_image
  terraform_smart_sanitization = var.terraform_smart_sanitization
  terraform_version            = var.terraform_version
  worker_pool_id               = local.worker_pool_id
}
