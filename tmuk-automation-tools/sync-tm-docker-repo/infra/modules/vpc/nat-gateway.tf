resource "aws_nat_gateway" "this" {
  allocation_id = var.eip_allocation_id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = {
    "Name" = "${var.environment}-${var.component}-nat-gateway"
  }
}
