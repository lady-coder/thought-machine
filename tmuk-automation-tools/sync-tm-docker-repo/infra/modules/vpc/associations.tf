resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "vpce" {
  count          = length(var.vpce_subnets) > 0 ? length(var.vpce_subnets) : 0
  subnet_id      = element(aws_subnet.vpce.*.id, count.index)
  route_table_id = aws_route_table.vpce.id
}
