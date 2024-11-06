resource "aws_vpc" "this" {
  #checkov:skip=CKV2_AWS_11: "Ensure VPC flow logging is enabled in all VPCs"
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.environment}-${var.component}-vpc"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  for_each   = toset(var.extra_cidr_blocks)
  vpc_id     = aws_vpc.this.id
  cidr_block = each.value
}

resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id
}
