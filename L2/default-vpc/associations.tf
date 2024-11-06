resource "aws_route_table_association" "private" {
  count     = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(
    aws_route_table.private.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

resource "aws_route_table_association" "protected" {
  count     = length(var.protected_subnets) > 0 ? length(var.protected_subnets) : 0
  subnet_id = element(aws_subnet.protected.*.id, count.index)
  route_table_id = element(
    aws_route_table.protected.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "tgw" {
  count     = length(var.tgw_subnets) > 0 ? length(var.tgw_subnets) : 0
  subnet_id = element(aws_subnet.tgw.*.id, count.index)
  route_table_id = element(
    aws_route_table.tgw.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
}
