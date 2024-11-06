resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }

  tags = {
    "Name" = "${local.name_prefix}-public-rt"
  }
}

resource "aws_route_table" "private_api" {
  count = length(var.private_api_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${local.name_prefix}-private-api-rt"
  }
}

resource "aws_route_table" "msk" {
  count = length(var.msk_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${local.name_prefix}-msk-rt"
  }
}

resource "aws_route_table" "db" {
  count = length(var.db_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${local.name_prefix}-db-rt"
  }
}

resource "aws_route_table" "endpoints" {
  count = length(var.endpoints_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${local.name_prefix}-endpoints-rt"
  }
}

resource "aws_route_table" "private" {
  count = local.nat_gateway_count > 1 ? local.nat_gateway_count : (length(var.private_subnets) > 0 ? 1 : 0)

  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${local.name_prefix}-private-rt-${count.index}"
  }
}

resource "aws_route" "private_nat_gateway" {
  count = local.nat_gateway_count > 0 ? local.nat_gateway_count : 0

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)
  timeouts {
    create = "5m"
  }

  depends_on = [aws_route_table.private]
}
