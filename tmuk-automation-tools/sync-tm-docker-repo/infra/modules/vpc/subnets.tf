resource "aws_subnet" "public" {
  count             = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name" = "${local.name_prefix}-public-subnet-${local.azs[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name"    = "${local.name_prefix}-private-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "vpce" {
  count             = length(var.vpce_subnets) > 0 ? length(var.vpce_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpce_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name"    = "${local.name_prefix}-vpce-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}
