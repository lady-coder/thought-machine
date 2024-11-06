resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name"    = "${join("-", compact([var.prefix, var.environment, var.component]))}-private-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "protected" {
  count             = length(var.protected_subnets) > 0 ? length(var.protected_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.protected_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name"    = "${join("-", compact([var.prefix, var.environment, var.component]))}-protected-subnet-${local.azs[count.index]}",
    "flowlog" = "REJECT"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-public-subnet-${local.azs[count.index]}"
  }
}

resource "aws_subnet" "tgw" {
  count             = length(var.tgw_subnets) > 0 ? length(var.tgw_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.tgw_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  tags = {
    "Name"    = "${join("-", compact([var.prefix, var.environment, var.component]))}-tgw-subnet-${local.azs[count.index]}"
    "flowlog" = "REJECT"
  }
}
