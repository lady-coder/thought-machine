resource "aws_nat_gateway" "this" {
  count = local.nat_gateway_count > 0 ? local.nat_gateway_count : 0

  allocation_id = element(
    var.eip_allocation_ids, count.index,
  )
  subnet_id = element(
    aws_subnet.public.*.id, count.index,
  )

  depends_on = [aws_internet_gateway.this]

  tags = {
    "Name" = "${var.environment}-${var.component}-nat-gateway-${count.index}"
  }
}
