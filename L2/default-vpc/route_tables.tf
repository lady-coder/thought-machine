resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }
  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-public-rt"
  }
}

resource "aws_route_table" "protected" {
  count = local.max_subnet_length > 0 ? local.nat_gateway_count : 0

  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-protected-rt-${count.index}"
  }
}

resource "aws_route_table" "tgw" {
  count = local.max_subnet_length > 0 ? local.nat_gateway_count : 0

  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-tgw-rt-${count.index}"
  }
}

resource "aws_route_table" "private" {
  count = local.max_subnet_length > 0 ? local.nat_gateway_count : 0

  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-private-rt-${count.index}"
  }
}

resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.private_subnets)) : 0

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)

  timeouts {
    create = "5m"
  }
}
