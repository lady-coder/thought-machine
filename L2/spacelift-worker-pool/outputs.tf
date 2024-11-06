output "id" {
  value       = spacelift_worker_pool.this.id
  description = "Spacelift worker pool ID to use with EC2 User Data"
}

output "config" {
  value       = spacelift_worker_pool.this.config
  description = "Credentials necessary to connect WorkerPool's workers to the control plane. It is in the form of a based-64 encoded token."
}
