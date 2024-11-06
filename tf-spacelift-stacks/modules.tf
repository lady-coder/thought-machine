resource "spacelift_module" "this" {
  for_each = local.modules

  project_root          = join("/", [each.value.module_level, format("%s", each.key)])
  name                  = each.key
  administrative        = each.value.administrative
  branch                = each.value.branch
  protect_from_deletion = each.value.protect_from_deletion
  repository            = "tf-modules"
  terraform_provider    = "aws"
  shared_accounts       = []
  labels                = [each.value.module_level]
}
