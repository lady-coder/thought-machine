resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    "Name" = "${local.name_prefix}-public-rt"
  }
}

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${local.name_prefix}-private-rt"
  }
}

resource "aws_route" "private_nat_gateway" {

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table" "vpce" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${local.name_prefix}-vpce-rt"
  }
}