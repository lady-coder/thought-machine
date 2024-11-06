data "spacelift_worker_pools" "deployed_worker_pools" {}

locals {
  name        = "${var.environment}-${var.component}-${var.context}"
  description = "L4 deployment against ${var.region} ${var.environment}-${var.component} covering the ${var.context} resources"

  worker_pool_id = lookup(element(data.spacelift_worker_pools.deployed_worker_pools.worker_pools, index(data.spacelift_worker_pools.deployed_worker_pools.worker_pools.*.name, var.worker_pool_name)), "worker_pool_id")

  after_init_commands = flatten([
    [
      "terraform fmt -recursive -check",
      "tflint --init",
      "tflint --disable-rule=terraform_module_pinned_source",
    ],
    var.additional_after_init_commands,
  ])
}
