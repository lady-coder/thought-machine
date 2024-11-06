resource "aws_subnet" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null

  tags = {
    "Name" = "${local.name_prefix}-public-subnet-${local.azs[count.index]}"
  }
}

resource "aws_subnet" "private_api" {
  count = length(var.private_api_subnets) > 0 ? length(var.private_api_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_api_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null

  tags = {
    "Name"    = "${local.name_prefix}-private-api-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null

  tags = {
    "Name"    = "${local.name_prefix}-private-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "msk" {
  count = length(var.msk_subnets) > 0 ? length(var.msk_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.msk_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null

  tags = {
    "Name"    = "${local.name_prefix}-msk-subnet-${local.azs[count.index]}",
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "db" {
  count = length(var.db_subnets) > 0 ? length(var.db_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.db_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null

  tags = {
    "Name"    = "${local.name_prefix}-db-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "endpoints" {
  count = length(var.endpoints_subnets) > 0 ? length(var.endpoints_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.endpoints_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null

  tags = {
    "Name"    = "${local.name_prefix}-endpoints-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}
