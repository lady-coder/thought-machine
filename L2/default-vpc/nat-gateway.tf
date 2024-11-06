resource "aws_nat_gateway" "this" {
  count      = var.enable_nat_gateway ? local.nat_gateway_count : 0
  depends_on = [aws_internet_gateway.this]

  allocation_id = length(var.eip_allocation_ids) > 0 ? element(var.eip_allocation_ids, var.single_nat_gateway ? 0 : count.index) : null
  subnet_id = element(
    aws_subnet.public.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-nat-gateway-${count.index}"
  }
}
