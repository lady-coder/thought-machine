resource "aws_eip" "this" {
  #checkov:skip=CKV2_AWS_19:Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances
  for_each = toset(var.elastic_ip_identifiers)
  // vpc      = true
  domain = "vpc"
  tags = {
    "Name" = "${var.environment}-${var.component}-${each.value}-eip"
  }
}
