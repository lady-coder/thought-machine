output "spacelift_worker_pool_id" {
  value       = var.create_spacelift_worker_pool ? module.spacelift_worker_pool[0].id : null
  description = "Spacelift worker pool ID"
}

