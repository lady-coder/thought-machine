data "aws_ssm_parameter" "csr" {
  name = "/${var.environment}/${var.component}/spacelift/csr"
}

resource "spacelift_worker_pool" "this" {
  name        = "${var.environment}-${var.component}-worker-pool"
  csr         = base64encode(data.aws_ssm_parameter.csr.value)
  description = "EC2 private worker pool for ${var.environment}-${var.component}"
}
