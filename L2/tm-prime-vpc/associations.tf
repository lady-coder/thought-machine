resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table_association" "private_api" {
  count = length(var.private_api_subnets) > 0 ? length(var.private_api_subnets) : 0

  subnet_id      = element(aws_subnet.private_api.*.id, count.index)
  route_table_id = aws_route_table.private_api[0].id
}

resource "aws_route_table_association" "msk" {
  count = length(var.msk_subnets) > 0 ? length(var.msk_subnets) : 0

  subnet_id      = element(aws_subnet.msk.*.id, count.index)
  route_table_id = aws_route_table.msk[0].id
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnets) > 0 ? length(var.db_subnets) : 0

  subnet_id      = element(aws_subnet.db.*.id, count.index)
  route_table_id = aws_route_table.db[0].id
}

resource "aws_route_table_association" "endpoints" {
  count = length(var.endpoints_subnets) > 0 ? length(var.endpoints_subnets) : 0

  subnet_id      = element(aws_subnet.endpoints.*.id, count.index)
  route_table_id = aws_route_table.endpoints[0].id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(
    aws_route_table.private.*.id,
    local.nat_gateway_count > 1 ? count.index : 0,
  )
}
