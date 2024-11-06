resource "aws_security_group" "this" {
  #checkov:skip=CKV_AWS_23: "Ensure every security groups rule has a description"
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  name        = "${var.environment}-${var.component}-spacelift-sg"
  description = "Spacelift security group for ${var.environment}-${var.component}-vpc"
  vpc_id      = var.vpc_id

  # Needed for SSM agent to work
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
